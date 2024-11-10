# Sample Application Deployment with Docker and Ansible

This setup automates the deployment of a Docker container running a sample Flask application.

## Contents
- **Dockerfile**: Used to build the application Docker image.
- **deploy_docker_container.yml**: Ansible playbook to automate Docker installation, image build, and container deployment.
- **Sample Application Files**:
  - `app.py`: Sample Flask application.
  - `requirements.txt`: Python dependencies.
  - `index.html`: Sample Web Page.

## Setup and Deployment

1. **Docker and Application Build**:
   - The Dockerfile defines a Python environment with a Flask application.
   - The Ansible playbook installs Docker, builds the Docker image, and runs the container.

2. **Running the Playbook**:
   - To deploy the application, use the command:
     ```bash
     ansible-playbook -i ansconfig.ini setup.yml
     ```
   - Ensure that `ansconfig.ini` contains the IP of the server.

3. **Accessing the Application**:
   - The application is accessible at `http://18.201.46.129:8080`.

## Configuration

- **Ports**: Modify `host_port` and `app_port` in the playbook to map different host/container ports.
- **Docker Image/Container Names**: Update `siansaWebServer` and `siansawebserver-image` in the playbook if needed.
