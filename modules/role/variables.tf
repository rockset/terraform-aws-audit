variable "buckets" {
  description = "Name of the S3 bucket(s) to configure access for the Rockset S3 integration."
  type        = list(string)
}

variable "bucket_prefix" {
  description = "S3 prefix for objects allowed to be accessed."
  type        = string
  default     = "*"
}

variable "rockset_external_id" {
  description = "AWS external id provided by the Rockset Console or the Rockset terraform provider."
  type        = string
}

variable "rockset_account_id" {
  description = "AWS account id provided by the Rockset Console or the Rockset terraform provider."
  type        = string
}

variable "rockset_role_name" {
  default     = "rockset-s3-integration"
  type        = string
  description = "Name of the AWS IAM role."
}

variable "kms_arn" {
  type = string
  description = "KMS ARN for tge key used to encrypt the audit bucket."
}
