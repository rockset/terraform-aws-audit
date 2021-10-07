output "bucket_name" {
  value = aws_s3_bucket.audit-trail.bucket
}

output "kms_arn" {
  value = length(aws_kms_key.audit-trail) == 0 ? "" : aws_kms_key.audit-trail[0].arn
}