terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS provider
provider "aws" {
  region = "eu-west-1"  # Ireland region
}

# Define a security group to allow SSH, HTTP, and HTTPS access
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH, HTTP, and HTTPS inbound traffic"
  
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows SSH from anywhere; consider restricting for security
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTP from anywhere
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allows HTTPS from anywhere
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_http"
  }
}
# Create IAM Instance Profile for GitHub Actions Runner
resource "aws_iam_instance_profile" "github_actions_instance_profile" {
  name = "github-actions-instance-profile"
  role = aws_iam_role.github_actions_runner_role.name
}
# Create IAM Role for GitHub Actions Runner
resource "aws_iam_role" "github_actions_runner_role" {
  name = "github-actions-runner-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })
}

# Attach IAM policy to the role for ECR and Git operations
resource "aws_iam_policy" "github_actions_policy" {
  name        = "github-actions-policy"
  description = "Policy for GitHub Actions runner to access Git and Docker operations"

  # Allow necessary actions for Git push, pull and Docker image operations
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer",
          "ecr:PutImage",
          "ec2:DescribeInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ecs:ListClusters",
          "ecs:DescribeClusters",
          "ecs:UpdateService",
          "iam:PassRole"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "codecommit:GitPull",
          "codecommit:GitPush"
        ]
        Resource = "*"
      },
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_github_actions_policy" {
  policy_arn = aws_iam_policy.github_actions_policy.arn
  role       = aws_iam_role.github_actions_runner_role.name
}

# Define the EC2 instance using your Ubuntu AMI
resource "aws_instance" "ubuntu_instance" {
  ami           = "ami-0d64bb532e0502c46"  # Your Ubuntu AMI ID
  instance_type = "t2.micro"                # Instance type (eligible for free tier)
  
  # Associate the security group
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  # Attach the IAM Instance Profile to the EC2 instance
  iam_instance_profile = aws_iam_instance_profile.github_actions_instance_profile.name
  
  # SSH key pair for SSH access
  key_name = "siansa-key"

  # (Optional) Add tags to the instance
  tags = {
    Name = "sansiaServer"
  }
}

