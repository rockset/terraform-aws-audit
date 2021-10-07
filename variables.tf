# bucket module

variable "bucket_path_prefix" {
  description = "S3 prefix for objects allowed to be accessed."
  type        = string
  default     = "*"
}

variable "rockset_external_id" {
  description = "AWS external id provided by the Rockset Console or the Rockset terraform provider."
  type        = string
  default     = ""
}

variable "rockset_account_id" {
  description = "AWS account id provided by the Rockset Console or the Rockset terraform provider."
  type        = string
  default     = ""
}

variable "rockset_role_name" {
  default     = "rockset-s3-integration"
  type        = string
  description = "Name of the AWS IAM role."
}

# role module

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket which will hold the Rockset audit trail."
  default     = ""
}

variable "bucket_prefix" {
  type        = string
  description = "Name of the S3 bucket prefix which will hold the Rockset audit trail."
  default     = "rockset-audit-trail-"
}

variable "acl" {
  type    = string
  default = "private"
}

variable "locked" {
  type        = bool
  default     = true
  description = "Object lock enabled, which prevents modification and deletion, unless the user has the s3:BypassGovernanceRetention permission."
}

variable "mfa_delete" {
  type        = bool
  default     = false
  description = "Require a MFA verified user to delete object in the bucket."
}

variable "encrypted" {
  type        = bool
  default     = true
  description = "Encrypt bucket contents using a KMS key."
}

variable "rockset_role" {
  type        = string
  default     = "arn:aws:iam::318212636800:role/audit-trail-copier"
  description = "Rockset role that is allowed to put objects into the audit trail bucket"
}

variable "object_lock_days" {
  type        = number
  default     = 365
  description = "Number of days each object is locked for."
}

variable "retention_type" {
  type        = string
  default     = "GOVERNANCE"
  description = "Retention type, either GOVERNANCE or COMPLIANCE."
  validation {
    condition     = can(contains(["GOVERNANCE", "COMPLIANCE"], var.retention_type))
    error_message = "The retention type must be either GOVERNANCE or COMPLIANCE."
  }
}

# ingest module

variable "workspace" {
  type        = string
  default     = "commons"
  description = "Name of the workspace for the audit trail collection."
}

variable "collection" {
  type        = string
  default     = "audit"
  description = "Name of the collection the audit trail is ingested into."
}

variable "retention_secs" {
  type        = number
  default     = 3600 * 24 * 30
  description = "Number of seconds to retain the "
}
