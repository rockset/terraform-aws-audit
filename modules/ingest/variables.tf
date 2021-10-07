variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket which will hold the Rockset audit trail."
  default     = ""
}

variable "workspace" {
  type        = string
  default     = "audit"
  description = "Name of the workspace for the audit trail collection."
}

variable "collection" {
  type        = string
  default     = ""
  description = "Name of the collection the audit trail is ingested into."
}

variable "retention_secs" {
  type        = number
  default     = 1
  description = "Number of seconds to retain the "
}

variable "rockset_role_arn" {
  type        = string
  description = "Rockset role used for ingestion."
}
