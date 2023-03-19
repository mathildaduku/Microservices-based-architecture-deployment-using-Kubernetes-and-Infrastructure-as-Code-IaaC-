

resource "kubernetes_namespace" "k8s-namespace-sockshop" {
  metadata {
    name = "sock-shop"
  }
}


data "kubectl_file_documents" "sock-file" {
    content = file("complete-demo.yaml")
}

resource "kubectl_manifest" "k8s-deployment-sockshop" {
    for_each  = data.kubectl_file_documents.sock-file.manifests
    yaml_body = each.value
}


resource "kubernetes_service" "k8s-service-sockshop" {
  metadata {
    name      = "front-end"
    namespace = kubernetes_namespace.k8s-namespace-sockshop.id
    annotations = {
      "prometheus.io/scrape" = "true"
    }
    labels = {
      name = "front-end"
    }
  }
  spec {
    selector = {
      name = "front-end"
    }
    port {
      name = "metrics"
      port        = 80
      target_port = 8079
    }
    type = "LoadBalancer"
  }
}


# output "myapp_load_balancer_dns" {
#   value = kubernetes_service.kube-voting-service.status.0.load_balancer.0.ingress.0.hostname
# }


output "sockshop_load_balancer_dns" {
  value = kubernetes_service.k8s-service-sockshop.status.0.load_balancer.0.ingress.0.hostname
}