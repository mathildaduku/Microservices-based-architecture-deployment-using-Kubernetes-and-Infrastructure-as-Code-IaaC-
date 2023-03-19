# PORTFOLIO DEPLOYMENT

# Create kubernetes Name space for portfolio


resource "kubernetes_namespace" "k8s-namespace-myapp" {
  metadata {
    name = "myapp"
  }
}

resource "kubernetes_deployment" "k8s-deployment-db" {
  metadata {
    name      = "psql-deployment"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
    labels = {
      name = "myapp"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "psql-pod"
        app = "myapp"
      }
    }
    template {
      metadata {
        name =  "psql-pod"
        labels = {
          name = "psql-pod"
          app = "myapp"
        }
      }
      spec {
        container {
          image = "postgres:9.4"
          name  = "postgres"

      env {
        name = "POSTGRES_USER"
        value = "postgres"
      }

      env{
        name = "POSTGRES_PASSWORD"
        value = "postgres"
      }

      port {
        container_port = 5432
      }
      }
    }
  }
}
}



# Create kubernetes  for cart service

resource "kubernetes_service" "k8s-service-db" {
  metadata {
    name      = "db"
    namespace = kubernetes_namespace.k8s-namespace-myapp.id
    /* annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "db-service"
        app = "myapp"
    }
  }
  spec {
    selector = {
      name = "psql-pod"
      app = "myapp"
    }
    port {
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_deployment" "k8s-deployment-redis" {
  metadata {
    name      = "redis-deployment"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
    labels = {
      name = "myapp"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "redis-pod"
        app = "myapp"
      }
    }
    template {
      metadata {
        name =  "redis-pod"
        labels = {
          name = "redis-pod"
          app = "myapp"
        }
      }
      spec {
        container {
          image = "redis"
          name  = "redis"

      port {
        container_port = 6379
      }
      }
    }
  }
}
}



# Create kubernetes  for cart service

resource "kubernetes_service" "kube-redis-service" {
  metadata {
    name      = "redis"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
    /* annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "redis-service"
        app = "myapp"
    }
  }
  spec {
    selector = {
      name = "redis-pod"
      app = "myapp"
    }
    port {
      port        = 6379
      target_port = 6379
    }
  }
}

resource "kubernetes_deployment" "k8s-deployment-result" {
  metadata {
    name      = "result-deployment"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
    labels = {
      name = "myapp"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "result-pod"
        app = "myapp"
      }
    }
    template {
      metadata {
        name =  "result-pod"
        labels = {
          name = "result-pod"
          app = "myapp"
        }
      }
      spec {
        container {
          image = "dockersamples/examplevotingapp_result"
          name  = "result-app"

      port {
        container_port = 80
      }
      }
    }
  }
}
}



# Create kubernetes  for cart service

resource "kubernetes_service" "kube-result-service" {
  metadata {
    name      = "result-service"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
   /*  annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "result-service"
        app = "myapp"
    }
  }
  spec {
    selector = {
      name = "result-pod"
      app = "myapp"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "k8s-deployment-voting" {
  metadata {
    name      = "voting-app-deployment"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
    labels = {
      name = "myapp"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        name = "voting-pod"
        app = "myapp"
      }
    }
    template {
      metadata {
        name =  "voting-pod"
        labels = {
          name = "voting-pod"
          app = "myapp"
        }
      }
      spec {
        container {
          image = "kodekloud/examplevotingapp_vote:v1"
          name  = "voting-app"

      port {
        container_port = 80
      }
      }
    }
  }
}
}



# Create kubernetes  for cart service

resource "kubernetes_service" "kube-voting-service" {
  metadata {
    name      = "voting-service"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
   /*  annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "voting-service"
        app = "myapp"
    }
  }
  spec {
    selector = {
      name = "voting-pod"
      app = "myapp"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "k8s-deployment-worker" {
  metadata {
    name      = "worker-deployment"
    namespace =  kubernetes_namespace.k8s-namespace-myapp.id
    labels = {
      name = "myapp"
    }
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        name = "worker-pod"
        app = "myapp"
      }
    }
    template {
      metadata {
        name =  "worker-pod"
        labels = {
          name = "worker-pod"
          app = "myapp"
        }
      }
      spec {
        container {
          image = "dockersamples/examplevotingapp_worker"
          name  = "worker-app"
      }
    }
  }
}
}