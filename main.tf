terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}

resource "random_id" "myRandomID" {
  byte_length = 8
}

#Creating S3 Bucket
resource "aws_s3_bucket" "data-bucket" {
  bucket = "databucket-${random_id.myRandomID.hex}"
}

#Creating EC2 Instance
resource "aws_instance" "terraformdemo-ec2" {
  ami                         = "ami-0049e4b5ba14b6d36"
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public-subnet.id
  #Attaching security group 
  vpc_security_group_ids = [aws_security_group.my-sg.id]

  tags = {
    Name = "terraformdemo-ec2"
  }
}

/*
output "name" {
  value = random_id.myRandomID.hex
}
*/
