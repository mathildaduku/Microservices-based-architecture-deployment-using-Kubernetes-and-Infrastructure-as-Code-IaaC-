# Project Description

This project is a solution to the task of deploying a microservices-based architecture on Kubernetes using an Infrastructure as Code (IaaC) approach. The goal of this project is to create a clear IaaC deployment that can be used to deploy services in a fast manner.

## Setup Details

The setup involves the following steps:

- Provision a webapp of your choosing with nginx/httpd frontend proxy and a database (mongo, postgresql etc) backend.
- Provision the Socks Shop example microservice application - https://microservices-demo.github.io/

## Task Instructions

- Everything needs to be deployed using an Infrastructure as Code approach.
- Use Prometheus as a monitoring tool.
- Use Ansible or Terraform as the configuration management tool.
- You can use an IaaS provider of your choice.
- The application should run on Kubernetes.

### For this task:

- Jenkins was used as the CI/CD tool for carrying out the entire task.
- Creation of the Jenkins server and Elastic Kubernetes cluster was done using Terraform.
- The Sock Shop app and Voting app were provisioned on the Kubernetes cluster.
- Prometheus and Grafana were used for monitoring the cluster.

The domain names used include:

- sockshop.mathidaduku.me
- webapp.mathidaduku.me

#### Below are screenshots of the executed tasks:

- My applications after deployment 

![](./Screenshot%20(242).png)

![](./Screenshot%20(243).png)

- Prometheus dashboard

![](./Screenshot%20(248).png)

- Grafana dashboard

![](./Screenshot%20(247).png)

![](./Screenshot%20(249).png)

![](./Screenshot%20(252).png)

![](./Screenshot%20(255).png)

- Successful Jenkins CI/CD pipeline

![](./Screenshot%20(244).png)



