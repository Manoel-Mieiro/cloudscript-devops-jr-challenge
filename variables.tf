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
