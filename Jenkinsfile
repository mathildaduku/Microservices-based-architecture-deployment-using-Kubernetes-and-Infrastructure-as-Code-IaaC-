#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('create-eks-cluster') {
                        sh "terraform init -upgrade"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('deploy-application') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                        // sh "aws eks --region us-east-1 update-kubeconfig --name demo"
                        // sh "kubectl apply -f complete-demo.yaml"
                        // sh "kubectl get pods -n sock-shop"
                        // sh "kubectl get svc -n sock-shop"
                        // sh "kubectl apply -f nginx-ingress.yaml"
                        // sh "kubectl get pods -n ingress-nginx"
                        // sh "kubectl get svc -n ingress-nginx"
                        // sh "kubectl apply -f sockshop-ingress.yaml"
                        // sh "kubectl get ing -n sockshop"
                        // sh "kubectl get svc -n ingress-nginx"
                    }
                }
            }
        }
        stage("Setup monitoring") {
            steps {
                script {
                    dir('manifests-monitoring') {
                        sh "kubectl create -f ./manifests-monitoring"
                    }
                }
            }
        }        
    }
}