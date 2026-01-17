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

variable "helm_nginx_create_namespace" {
  type    = bool
  default = false
}

variable "k8s_ingress_name" {
  type = string
}

variable "k8s_demo_path" {
  type = string
}

variable "helm_hello_world_name" {
  type = string
}

variable "helm_hello_world_chart" {
  type = string
}

variable "helm_hello_world_repository" {
  type = string
}

variable "helm_hello_world_namespace" {
  type = string
}

variable "helm_hello_world_create_namespace" {
  type    = bool
  default = false
}