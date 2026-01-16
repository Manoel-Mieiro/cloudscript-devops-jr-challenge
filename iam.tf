module "iam_lab_user" {
  source = "terraform-aws-modules/iam/aws//examples/iam-user"
}

module "iam_role_vpc" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.3.0"

  name = "vpc-administrator"
}

module "iam_role_eks" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.3.0"
  name    = "eks-administrator"
}

module "iam_role_ec2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.3.0"
  name    = "ec2-administrator"
}



