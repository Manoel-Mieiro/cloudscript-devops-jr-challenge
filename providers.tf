terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.30"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

provider "aws" {
  alias  = "default"
  region = "us-west-2"

  assume_role {
    role_arn = var.default_arn
  }
}


provider "aws" {
  alias  = "EksNetworkProvisioningRole"
  region = "us-west-2"

  assume_role {
    role_arn = var.vpc_role_arn
  }
}
provider "aws" {
  alias  = "EksAdmin"
  region = "us-west-2"

  assume_role {
    role_arn = var.eks_role_arn
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}