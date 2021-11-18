output "bucket_name" {
  value = module.bucket.name
}

output "bucket_region" {
  value = module.bucket.region
}

output "bucket_kms_arn" {
  value = module.bucket.kms_arn
}

output "bucket_account" {
  value = module.bucket.account
}
output "role_arn" {
  value = module.rockset-role.role_arn
}
