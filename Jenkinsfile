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
                        sh "terraform init"
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
                    }
                }
            }
        }
        stage("Setup monitoring") {
            steps {
                script {
                    dir('manifests-monitoring') {
                        sh "aws eks --region us-east-1 update-kubeconfig --name demo"
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                        sh "kubectl get pods -n monitoring"
                        sh "kubectl port-forward -n monitoring prometheus-deployment-89bb7b4bf-rld45 9090"
                    }
                }
            }
        }        
    }
}
