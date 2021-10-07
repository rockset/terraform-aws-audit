terraform {
  required_version = "~> 1.0"
  required_providers {
    aws     = {
      source = "hashicorp/aws"
    }
    rockset = {
      source = "rockset/rockset"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
  profile = "sandbox"
}

module "audit-trail" {
  source = "./.."
  rockset_role_name = "test-s3-integration"
}

output "bucket_name" {
  value = module.audit-trail.bucket_name
}
