terraform {
  required_providers {
    aws     = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    time    = {
      source = "hashicorp/time"
    }
    rockset = {
      source  = "rockset/rockset"
      version = "~> 0.4.0"
    }
  }
  required_version = "~> 1.0.0"
}
