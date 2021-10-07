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
