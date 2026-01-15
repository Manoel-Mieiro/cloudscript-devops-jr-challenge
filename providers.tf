terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  alias = "EksNetworkProvisioningRole"
  region = "us-west-2"

  assume_role {
    role_arn = var.vpc_role_arn
  }
}
