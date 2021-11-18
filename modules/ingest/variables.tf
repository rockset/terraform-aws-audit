variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket which will hold the Rockset audit trail."
}

variable "workspace" {
  type        = string
  description = "Name of the workspace for the audit trail collection."
}

variable "collection" {
  type        = string
  description = "Name of the collection the audit trail is ingested into."
}

variable "retention_secs" {
  type        = number
  default     = 3600*24*30
  description = "Number of seconds to retain the documents (30 days)"
}

variable "rockset_role_arn" {
  type        = string
  description = "Rockset role used for ingestion."
}
