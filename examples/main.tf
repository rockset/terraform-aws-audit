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

provider "rockset" {}

provider "aws" {
  region  = "us-west-2"
}

module "audit-trail" {
  source = "rockset/audit/aws"
}

output "bucket_name" {
  value = module.audit-trail.bucket_name
}

output "integration_name" {
  value = module.audit-trail.integration_name
}
