Terraform AWS Infrastructure Project
Overview

This project provisions a complete AWS cloud environment using Terraform.
It follows Infrastructure as Code (IaC) best practices, uses modular design, and creates a production-ready environment that includes networking, compute, database, and security resources.

This project demonstrates my hands-on skills in Terraform, AWS, cloud architecture, and automation.

Architecture Diagram (High-Level)

VPC → Subnets → Route Tables → Internet Gateway → Security Groups → EC2 → RDS

Features
1. Networking (VPC Module)

Creates a custom VPC

Public and private subnets across 2 Availability Zones

Internet Gateway + Route Tables

NAT Gateway (optional)

CIDR blocks customizable through variables

2. Compute (EC2 Module)

Launches EC2 instances in public or private subnets

Configurable instance type, key pair, AMI

User-data script for automatic provisioning

Security Group rules for SSH/HTTP access

3. Database (RDS Module)

Creates Amazon RDS MySQL/PostgreSQL

Multi-AZ (optional)

Automatically generates strong password (stored in AWS Secrets Manager or variables)

Private subnet deployment for security

4. Security

Security Groups for EC2, RDS, and bastion host

Least privilege rules

Separation of public/private layer

Outputs masked to protect secrets

5. Terraform Structure

The project follows best practices with multiple files:

/modules
    /vpc
    /ec2
    /rds
/main.tf
/variables.tf
/outputs.tf
/provider.tf
/terraform.tfvars

Requirements

Terraform v1.5+

AWS CLI configured

AWS account

IAM user with appropriate permissions

How to Use
1. Clone the repository
git clone https://github.com/<your-username>/<repo-name>.git
cd <repo-name>

2. Initialize Terraform
terraform init

3. Validate
terraform validate

4. Review execution plan
terraform plan

5. Apply and deploy AWS resources
terraform apply

6. Destroy infrastructure
terraform destroy

Variables

Example of important variables:

Variable	Description	Example
aws_region	AWS region	us-east-1
vpc_cidr	VPC CIDR block	10.0.0.0/16
instance_type	EC2 size	t2.micro
db_engine	RDS engine	mysql

All variable values can be set in terraform.tfvars.

Outputs

This project will output:

VPC ID

Public subnet IDs

Private subnet IDs

EC2 public IP

RDS endpoint (masked or sensitive output)
