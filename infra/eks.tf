module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "21.14.0"
  name                                     = var.eks_name
  kubernetes_version                       = var.eks_k8s_version
  endpoint_public_access                   = var.eks_endpoint_public_access
  enable_cluster_creator_admin_permissions = var.eks_creator_admin_permissions
  create_cloudwatch_log_group              = var.eks_create_cloudwatch
  encryption_config                        = var.eks_encryption_config
  endpoint_public_access_cidrs             = var.eks_public_access_cidrs
  additional_security_group_ids            = [module.vpc.default_security_group_id]
  addons                                   = var.eks_addons

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets


  eks_managed_node_groups = {
    default = {
      ami_type       = var.eks_node_ami_type
      instance_types = var.eks_node_instance_type
      capacity_type  = var.eks_node_capacity_type
      min_size       = var.eks_node_min_size
      max_size       = var.eks_node_max_size
      desired_size   = var.eks_node_desired_size
    }
  }


  tags = {
    "projeto"       = "Desafio Técnico CloudScript",
    "ambiente"      = "DevTest",
    "centroDeCusto" = "1234",
    "infraAsCode"   = "Terraform",
  }
}
