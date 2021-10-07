locals {
  bucket_name = var.bucket_name == "" ? var.bucket_prefix : var.bucket_name
}

resource "aws_s3_bucket" "audit-trail" {
  bucket        = var.bucket_name == "" ? null : var.bucket_name
  bucket_prefix = var.bucket_name == "" ? var.bucket_prefix : null

  acl = var.acl

  versioning {
    enabled    = var.locked
    mfa_delete = var.mfa_delete
  }

  dynamic "object_lock_configuration" {
    for_each = var.locked ? [""] : []
    content {
      object_lock_enabled = "Enabled"
      rule {
        default_retention {
          mode = var.retention_type
          days = var.object_lock_days
        }
      }
    }
  }

  dynamic "server_side_encryption_configuration" {
    for_each = var.encrypted ? [""] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm     = "aws:kms"
          kms_master_key_id = aws_kms_key.audit-trail[0].id
        }
        bucket_key_enabled = true
      }
    }
  }
}

resource "aws_s3_bucket_policy" "audit-trail" {
  bucket = aws_s3_bucket.audit-trail.bucket

  policy = templatefile("${path.module}/data/bucket_policy.json", {
    bucket    = aws_s3_bucket.audit-trail.bucket,
    principal = var.rockset_role
  })

  depends_on = [aws_s3_bucket.audit-trail]
}

resource "aws_s3_bucket_public_access_block" "audit-trail" {
  bucket = aws_s3_bucket.audit-trail.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket_policy.audit-trail]
}

resource "aws_s3_bucket_ownership_controls" "audit-trail" {
  bucket = aws_s3_bucket.audit-trail.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [aws_s3_bucket_public_access_block.audit-trail]
}

# this object makes it possible to create the integration when there are
# no audit logs in the
resource "aws_s3_bucket_object" "dummy" {
  bucket = aws_s3_bucket.audit-trail.bucket
  key    = "bucket.json"
  content = "{}"
}

resource "aws_kms_key" "audit-trail" {
  count       = var.encrypted ? 1 : 0
  description = "key used for bucket encryption of ${local.bucket_name}"
  policy      = templatefile("${path.module}/data/kms_policy.json", {
    principal = var.rockset_role,
    account   = data.aws_caller_identity.current.account_id
  })
}

data "aws_caller_identity" "current" {}
