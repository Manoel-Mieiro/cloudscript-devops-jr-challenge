resource "helm_release" "hello_world" {
  name             = var.helm_hello_world_name
  namespace        = var.helm_hello_world_namespace
  repository       = var.helm_hello_world_repository
  chart            = var.helm_hello_world_chart
  create_namespace = var.helm_hello_world_create_namespace
}
