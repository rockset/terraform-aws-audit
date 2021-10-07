terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    rockset = {
      source = "rockset/rockset"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

data "rockset_account" "current" {}

module "bucket" {
  source           = "./modules/bucket"
  bucket_name      = var.bucket_name
  bucket_prefix    = var.bucket_prefix
  acl              = var.acl
  locked           = var.locked
  mfa_delete       = var.mfa_delete
  encrypted        = var.encrypted
  rockset_role     = var.rockset_role
  object_lock_days = var.object_lock_days
  retention_type   = var.retention_type
}

module "rockset-role" {
  source              = "./modules/role"
  buckets             = [module.bucket.bucket_name]
  bucket_prefix       = var.bucket_path_prefix
  kms_arn             = module.bucket.kms_arn
  rockset_role_name   = var.rockset_role_name
  rockset_account_id  = var.rockset_account_id == "" ? data.rockset_account.current.account_id : var.rockset_account_id
  rockset_external_id = var.rockset_external_id == "" ? data.rockset_account.current.external_id : var.rockset_external_id
}

module "ingest" {
  source           = "./modules/ingest"
  bucket_name      = module.bucket.bucket_name
  rockset_role_arn = module.rockset-role.rockset-role-arn
  workspace        = var.workspace
  collection       = var.collection
  retention_secs   = var.retention_secs
}
