
# SOCKS SHOP DEPLOYMENT

# Create kubernetes Name space for socks shop app

resource "kubernetes_namespace" "k8s-namespace-sockshop" {
  metadata {
    name = "sock-shop"
  }
}

# Create kubectl deployment for socks app

data "kubectl_file_documents" "sock-file" {
    content = file("complete-demo.yaml")
}

resource "kubectl_manifest" "k8s-deployment-sockshop" {
    for_each  = data.kubectl_file_documents.sock-file.manifests
    yaml_body = each.value
}

# Create separate kubernetes service for socks shop frontend

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

# Print out loadbalancer DNS hostname for portfolio deployment

output "myapp_load_balancer_dns" {
  value = kubernetes_service.k8s-service-myapp.status.0.load_balancer.0.ingress.0.hostname
}

# Print out loadbalancer DNS hostname for socks deployment

output "sockshop_load_balancer_dns" {
  value = kubernetes_service.todo_list.status.0.load_balancer.0.ingress.0.hostname
}