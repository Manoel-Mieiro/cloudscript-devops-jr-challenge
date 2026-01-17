resource "helm_release" "ingress_nginx" {
  name             = var.helm_nginx_name
  chart            = var.helm_nginx_chart_name
  repository       = "https://kubernetes.github.io/ingress-nginx"
  namespace        = var.nginx_namespace_name
  version          = var.helm_nginx_chart_version
  create_namespace = var.helm_nginx_create_namespace

  timeout = 300


  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
}

resource "kubernetes_ingress_v1" "ingress_nginx" {
  wait_for_load_balancer = true
  metadata {
    name = var.k8s_ingress_name
  }

  spec {
    ingress_class_name = "nginx"

    rule {
      http {
        path {
          backend {
            service {
              name = helm_release.hello_world.name
              port {
                number = 5678
              }
            }
          }

          path = var.k8s_demo_path
        }
      }
    }

  }
  depends_on = [helm_release.hello_world, helm_release.ingress_nginx]
}


