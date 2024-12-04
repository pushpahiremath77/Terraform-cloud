terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67.0"
    }
  }
}

#AWS provider
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "my_ec2" {
  instance_type = var.instance_type
  ami           = var.ami_id
  key_name      = var.key_pair
  
  tags = {
    Name = "ec2-cloud"
  }
}