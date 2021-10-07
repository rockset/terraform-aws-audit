resource "aws_iam_policy" "rockset-s3-integration" {
  name   = var.rockset_role_name
  policy = templatefile("${path.module}/data/policy.json", {
    buckets = var.buckets
    prefix  = var.bucket_prefix
    kms_arn = var.kms_arn
  })
}

resource "aws_iam_role" "rockset" {
  name               = var.rockset_role_name
  assume_role_policy = data.aws_iam_policy_document.rockset-trust-policy.json
}

data "aws_iam_policy_document" "rockset-trust-policy" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "arn:aws:iam::${var.rockset_account_id}:root"
      ]
      type        = "AWS"
    }
    condition {
      test     = "StringEquals"
      values   = [
        var.rockset_external_id
      ]
      variable = "sts:ExternalId"
    }
  }
}

resource "aws_iam_role_policy_attachment" "rockset_s3_integration" {
  role       = aws_iam_role.rockset.name
  policy_arn = aws_iam_policy.rockset-s3-integration.arn
}
