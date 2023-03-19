This project is a solution to the task of deploying microservices-based architecture on Kubernetes using an Infrastructure as Code (IaaC) approach. The goal of this project is to create a clear IaaC deployment that can be used to deploy services in a fast manner.

Setup Details:

The setup involves the following steps:

Provision a webapp of your choosing with nginx/httpd frontend proxy and a database (mongo, postgresql etc) backend.
Provision the Socks Shop example microservice application - https://microservices-demo.github.io/


Task Instructions: 

Everything needs to be deployed using an Infrastructure as Code approach.
Use Prometheus as a monitoring tool.
Use Ansible or Terraform as the configuration management tool.
You can use an IaaS provider of your choice.
The application should run on Kubernetes.

Domain names include :
sockshop.mathidaduku.me
webapp.mathidaduku.me

Below are screenshots of my applications after deployment and my successful Jenkins CI/CD pipeline 

![](../jenkins-pipeline/Screenshot%20(242).png)

![](../jenkins-pipeline/Screenshot%20(243).png)

![](../jenkins-pipeline/Screenshot%20(244).png)


