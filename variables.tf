variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = false
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = false
}

variable "vpc_manage_default_acl" {
  type    = bool
  default = false
}

variable "vpc_enable_nat_gateway" {
  type    = bool
  default = false
}

variable "vpc_single_nat_gateway" {
  type    = bool
  default = false
}

variable "vpc_azs" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b"]
}

variable "vpc_public_subnet_names" {
  type = list(string)
}

variable "vpc_private_subnet_names" {
  type = list(string)
}

variable "vpc_role_arn" {
  type      = string
  sensitive = true
}

variable "eks_role_arn" {
  type      = string
  sensitive = true
}

variable "eks_name" {
  type = string
}

variable "eks_k8s_version" {
  type = string
}

variable "eks_endpoint_public_access" {
  type    = bool
  default = false
}

variable "eks_creator_admin_permissions" {
  description = "Adds the current caller identity as an administrator via cluster access entry"
  type        = bool
  default     = false
}


variable "eks_node_ami_type" {
  type = string
}

variable "eks_node_instance_type" {
  type = list(string)
}

variable "eks_node_min_size" {
  type    = number
  default = 0
}

variable "eks_node_max_size" {
  type    = number
  default = 2
}

variable "eks_node_desired_size" {
  type    = number
  default = 1
}

variable "eks_create_cloudwatch" {
  type    = bool
  default = false
}

variable "eks_node_capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "eks_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster"
  type = object({
    provider_key_arn = optional(string)
    resources        = optional(list(string), ["secrets"])
  })
  default = null
}

variable "eks_public_access_cidrs" {
  description = "	List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = null
}

variable "default_arn" {
  type = string
}

variable "nginx_namespace_name" {
  type = string
}

variable "helm_nginx_name" {
  type = string
}

variable "helm_nginx_chart_name" {
  type = string
}

variable "helm_nginx_chart_version" {
  type = string
}

