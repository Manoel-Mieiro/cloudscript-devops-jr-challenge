module "eks" {
  source                                   = "terraform-aws-modules/eks/aws"
  version                                  = "21.14.0"
  name                                     = var.eks_name
  kubernetes_version                       = var.eks_k8s_version
  endpoint_public_access                   = var.eks_endpoint_public_access
  enable_cluster_creator_admin_permissions = var.eks_creator_admin_permissions

  vpc_id     = module.vpc.default_vpc_id
  subnet_ids = merge(module.vpc.public_subnets, module.vpc.private_subnets)

  eks_managed_node_groups = {
    default = {
      ami_type       = var.eks_node_ami_type
      instance_types = var.eks_node_instance_type
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
