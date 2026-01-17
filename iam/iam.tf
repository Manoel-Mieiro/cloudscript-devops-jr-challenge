module "iam_lab_user" {
  source  = "terraform-aws-modules/iam/aws//examples/iam-user"
  version = "6.3.0"
}

resource "aws_iam_user_policy_attachment" "vpc" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_user_policy_attachment" "eks_cluster_policy" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_user_policy_attachment" "eks_service_policy" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_user_policy_attachment" "eks_worker_node_policy" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_user_policy_attachment" "eks_cni_policy" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_user_policy_attachment" "ec2" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "iam" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_user_policy_attachment" "ssm" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_user_policy_attachment" "eks-admin" {
  user       = "vasya.pupkin"
  policy_arn = "arn:aws:iam::582719176135:policy/EksAdministratorPolicy"
}
