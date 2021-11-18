output "name" {
  value = aws_s3_bucket.audit-trail.bucket
}

output "kms_arn" {
  value = length(aws_kms_key.audit-trail) == 0 ? "" : aws_kms_key.audit-trail[0].arn
}

output "region" {
  value = aws_s3_bucket.audit-trail.region
}

output "account" {
  value = data.aws_caller_identity.current.account_id
}