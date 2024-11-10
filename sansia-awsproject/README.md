Here’s a `README.md` file tailored for the `main.tf` Terraform script provided:

---

# Terraform AWS EC2 Setup with IAM Roles and Security Groups

This project leverages Terraform to deploy and configure an AWS EC2 instance, set up necessary IAM roles and policies, and define security groups to allow SSH, HTTP, and HTTPS traffic.

## Overview

The `main.tf` file defines:
1. **AWS Provider Configuration**: Specifies the AWS region.
2. **Security Groups**: Creates a security group to allow inbound SSH, HTTP, and HTTPS access to the EC2 instance.
3. **IAM Role and Policies**: Defines IAM roles and policies to grant GitHub Actions runners necessary permissions.
4. **EC2 Instance**: Configures and launches an Ubuntu EC2 instance with a specified security group, IAM instance profile, and SSH key.

## Requirements

- **Terraform** version `>= 1.0.0`
- AWS credentials with permissions to create EC2 instances, IAM roles, policies, and security groups
- An SSH key pair (in AWS) for accessing the instance

## Configuration Details

- **Provider**: Configured to use AWS in the `eu-west-1` region.
- **Security Group**: Allows:
  - SSH access (port 22) from any IP.
  - HTTP (port 80) and HTTPS (port 443) access from any IP.
- **IAM Role and Policies**:
  - Creates a role for the GitHub Actions runner with policies allowing interaction with ECR, EC2, ECS, and CodeCommit.
  - Attaches a policy for Docker image management and Git operations.
- **EC2 Instance**:
  - Launches an Ubuntu instance (`ami-0d64bb532e0502c46`) of type `t2.micro`.
  - Associates the previously defined security group and IAM instance profile.
  - Uses the `siansa-key` SSH key pair for secure access.

## Usage

1. **Initialize Terraform**: Run this command to initialize the project and download necessary providers.
   ```bash
   terraform init
   ```

2. **Validate Configuration**: Check the configuration syntax.
   ```bash
   terraform validate
   ```

3. **Plan the Deployment**: Generate an execution plan to review what Terraform will create.
   ```bash
   terraform plan
   ```

4. **Deploy Infrastructure**: Apply the configuration to create the infrastructure in AWS.
   ```bash
   terraform apply
   ```

5. **Destroy Infrastructure**: When done, clean up the resources to avoid charges.
   ```bash
   terraform destroy
   ```

## Notes

- **AMI**: The instance uses a specific Ubuntu AMI (`ami-0d64bb532e0502c46`). You may need to update this for your region.
- **SSH Key**: The `siansa-key` key pair must be pre-existing in your AWS account.
- **IAM Permissions**: Ensure your AWS user has permissions to create EC2 instances, IAM roles, policies, and security groups.

## File Structure

- `main.tf`: Main Terraform configuration file containing all resources.
  
This setup is suitable for automating infrastructure deployments in AWS with GitHub Actions and can be extended based on additional application requirements.