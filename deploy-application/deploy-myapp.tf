# PORTFOLIO DEPLOYMENT

# Create kubernetes Name space for portfolio


resource "kubernetes_namespace" "k8s-namespace-myapp" {
  metadata {
    name = "myapp"
  }
}

# data "kubectl_file_documents" "app-file" {
#     content = file("myapp.yaml")
# }

# resource "kubectl_manifest" "k8s-deployment-myapp" {
#     for_each  = data.kubectl_file_documents.app-file.manifests
#     yaml_body = each.value
# }

resource "kubernetes_deployment" "todo_list" {
  metadata {
    name      = "todo-list"
    namespace = kubernetes_namespace.k8s-namespace-myapp.id
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "todo-list"
      }
    }
    template {
      metadata {
        labels = {
          app = "todo-list"
        }
      }
      spec {
        container {
          name  = "todo-list"
          image = "my-todo-list-image:latest"
          env {
            name  = "DATABASE_URL"
            value = "postgresql://todo-user:todo-pass@postgres/todo-db"
          }
          port {
            container_port = 5000
          }
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "todo_list" {
  metadata {
    name = "todo-list"
    namespace = kubernetes_namespace.k8s-namespace-myapp.id
  }
  spec {
    selector = {
      app = "todo-list"
    }
    port {
      name = "http"
      port = 80
      target_port = 5000
    }
    type = "LoadBalancer"
  }
}


resource "kubernetes_deployment" "postgres" {
  metadata {
    name = "postgres"
    namespace = kubernetes_namespace.k8s-namespace-myapp.id
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "postgres"
      }
    }
    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }
      spec {
        container {
          name = "postgres"
          image = "postgres:latest"
          env {
            name = "POSTGRES_USER"
            value = "todo-user"
          }
          env {
            name = "POSTGRES_PASSWORD"
            value = "todo-pass"
          }
          env {
            name = "POSTGRES_DB"
            value = "todo-db"
          }
          port {
            container_port = 5432
          }
          resources {
            limits = {
              cpu = "0.5"
              memory = "512Mi"
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "postgres" {
  metadata {
    name = "postgres"
    namespace = kubernetes_namespace.k8s-namespace-myapp.id
  }
  spec {
    selector = {
      app = "postgres"
    }
    port {
      name = "postgres"
      port = 5432
      target_port = 5432
    }
    type = "ClusterIP"
  }
}



 



