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


Source with CI/CD Piplene can be found in the following git repo
https://github.com/soniamohan24/siansiansaWebServer.git

AWS Deployment Demo
https://drive.google.com/file/d/1GqvGy62bkhaPfCgA08XFKPqe9uFvPKCV/view?usp=sharing

Demo Video using Azure is given in thelink below
https://mydbs-my.sharepoint.com/:v:/g/personal/20049582_mydbs_ie/ESqKUyTzdmZFqkPhmA6-6YgBRWUVR8JK7_p-nRT5-wRqWA?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=XKrEik
