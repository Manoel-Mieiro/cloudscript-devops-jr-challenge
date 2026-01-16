module "iam_role_vpc" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.3.0"

  name = "VpcProvisionerRole"
}



module "iam_role_eks" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.3.0"
  name    = "EksProvisionerRole"
}

module "iam_role_k8s" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.3.0"
  name    = "KubernetesIamProvisionerRole"
}


