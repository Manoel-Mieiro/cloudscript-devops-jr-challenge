resource "kubernetes_namespace" "ingress_nginx" {
  metadata {
    name = var.nginx_namespace_name
  }
}

resource "helm_release" "ingress_nginx" {
  name       = var.helm_nginx_name
  chart      = var.helm_nginx_chart_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  version    = var.helm_nginx_chart_version

  timeout = 300


  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.annotations.service.beta.kubernetes.io/aws-load-balancer-scheme"
    value = "internet-facing"
  }

  depends_on = [kubernetes_namespace.ingress_nginx]
}
