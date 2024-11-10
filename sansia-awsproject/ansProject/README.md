#set-docker.yml
# Ansible Automation for Server Configuration

## Overview
This automation playbook sets up a server with Docker installed and ensures that Docker starts on boot. It uses Ansible to configure an AWS EC2 instance.

## Requirements
- Ansible installed on your local machine
- An AWS EC2 instance running Ubuntu (or similar Linux-based OS)
- An SSH key to connect to the EC2 instance
- The `docker.io` and `git` packages

## Files
- `setup-docker.yml`: The main Ansible playbook for installing Docker and configuring it to start on boot.
- `ansconfig.ini`: The inventory file where you define your EC2 instance and its SSH details.

## How to Run

1. Modify `ansconfig.ini` with your EC2 instance's public IP and SSH private key path.
2. Run the playbook:
   ```bash
   ansible-playbook -i ansconfig.ini setup-docker.yml


### Result
- Once the playbook runs successfully, your EC2 instance will be fully configured with Docker installed, running, and set to start on boot.
- You can extend this playbook to include additional configurations like deploying Docker containers or managing Docker volumes. 

This automation will save you time and ensure consistency when provisioning multiple EC2 instances in the future.


#setup.yml
# Automated Server Configuration with Ansible

This setup automates the configuration of a server environment using Ansible, ensuring that Docker, Git, and Python dependencies are installed, and a web server is deployed in a Docker container.

## Overview

The playbook performs the following steps:
1. **Update apt Repository**: Ensures the latest package information.
2. **Install Docker, Git, and Python Dependencies**: Installs `docker.io`, `git`, `python3-pip`, and `python3-venv`.
3. **User Permissions**: Adds the specified user to the Docker group to allow Docker commands without `sudo`.
4. **GitHub SSH Configuration**: Adds GitHub to known hosts to prevent SSH prompts.
5. **Clone GitHub Repository**: Clones the specified repository containing the web server project.
6. **Python Virtual Environment**:
   - Creates a virtual environment in the cloned repository.
   - Installs project dependencies specified in `requirements.txt`.
   - Installs `Gunicorn` for production server management.
7. **Docker Configuration**:
   - Ensures Docker is started and enabled to start on boot.
   - Builds a Docker image from the project’s `Dockerfile`.
   - Runs a Docker container, exposing the application on port 8080.

## Requirements

- **Ansible**: Ensure Ansible is installed on the local machine executing the playbook.
- **SSH Access**: SSH access to the server with `sudo` privileges.

## Running the Playbook

To run the playbook, use the following command:

```bash

ansible-playbook -i ansconfig.ini setup.yml