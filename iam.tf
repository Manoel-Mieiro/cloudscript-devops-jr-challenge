module "iam_lab_user" {
  source = "terraform-aws-modules/iam/aws//examples/iam-user"
}

resource "aws_iam_user_policy_attachment" "vpc" {
  user       = data.aws_iam_user.vasya-pupkin.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_user_policy_attachment" "eks_cluster_policy" {
  user       = data.aws_iam_user.vasya-pupkin.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_user_policy_attachment" "eks_service_policy" {
  user       = data.aws_iam_user.vasya-pupkin.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_user_policy_attachment" "eks_worker_node_policy" {
  user       = data.aws_iam_user.vasya-pupkin.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_user_policy_attachment" "eks_cni_policy" {
  user       = data.aws_iam_user.vasya-pupkin.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_user_policy_attachment" "ec2" {
  user       = data.aws_iam_user.vasya-pupkin.user_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_user_policy_attachment" "iam" {
  user       = data.aws_iam_user.vasya-pupkin.user_name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

