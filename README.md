Automated Container deployment and Administration in the cloud

This project sets up a CI/CD pipeline to automate deploying a containerized application on AWS EC2. The process includes provisioning infrastructure with Terraform, configuring the server with Ansible, deploying a Docker container, and automating the workflow with GitHub Actions.

Workflow Summary

Infrastructure Setup (Terraform)
Provision AWS resources: VPC, EC2, and Security Groups.
Commands: terraform init → terraform plan → terraform apply
Configuration Management (Ansible)
Automate Docker installation and server configuration on EC2.
Command: ansible-playbook -i inventory.ini setup-docker.yml
Docker Deployment
Create a Dockerfile to containerize the app and deploy it on EC2.
Commands: docker build -t myapp . → docker run -p 8080:8080 myapp
CI/CD Pipeline (GitHub Actions)
Automate builds and deployments triggered by GitHub pushes.
YAML workflow file (.github/workflows/ci-cd-pipeline.yml) builds, pushes, and deploys the Docker container to EC2.
Key Files

main.tf (Terraform), setup-docker.yml (Ansible), Dockerfile, ci-cd-pipeline.yml