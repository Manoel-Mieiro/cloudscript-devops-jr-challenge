module "vpc" {
  source                     = "terraform-aws-modules/vpc/aws"
  version                    = "6.6.0"
  name                       = var.vpc_name
  cidr                       = var.vpc_cidr
  azs                        = var.vpc_azs
  manage_default_network_acl = var.vpc_manage_default_acl
  public_subnets             = [cidrsubnet(var.vpc_cidr, 2, 0), cidrsubnet(var.vpc_cidr, 2, 1)]
  public_subnet_names        = var.vpc_public_subnet_names
  private_subnets            = [cidrsubnet(var.vpc_cidr, 2, 2), cidrsubnet(var.vpc_cidr, 2, 3)]
  private_subnet_names       = var.vpc_private_subnet_names

  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }

  tags = {
    "projeto"       = "Desafio Técnico CloudScript",
    "ambiente"      = "DevTest",
    "centroDeCusto" = "1234",
    "infraAsCode"   = "Terraform",
  }
}
