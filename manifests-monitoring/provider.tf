
provider "aws" {
  region     = "us-east-1"
}


terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "project-bucket-06-57"
    region = "us-east-1"
    key = "prometheus/terraform.tfstate"
  }
}


data "aws_eks_cluster" "demo" {
  name = "demo"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo.certificate_authority[0].data)
  version          = "2.16.1"

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.demo.name]
    command     = "aws"
  }
}


provider "kubectl" {
  host                   = data.aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.demo.name]
    command     = "aws"
  }
}


data "aws_eks_cluster_auth" "eks-token" {
  name = "demo"
}


provider "helm" {
  kubernetes {
  host                   = data.aws_eks_cluster.demo.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.demo.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.eks-token.token

  }
 
}