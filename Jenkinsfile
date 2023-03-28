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
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('deploy-application') {
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
        stage("Setup monitoring") {
            steps {
                script {
                    dir('manifests-monitoring') {
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }        
    }
}
