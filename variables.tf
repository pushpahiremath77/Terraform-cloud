variable "region" {
        description = "The AWS region where my resources will be created"
        type        = string
        default     = "ap-southeast-1"
}

variable "access_key"{
type    = string
default = "AKIATTSKFVUKOQNPJ77D"
}

variable "secret_key"{
type    = string
default = "nfJJKyCNYJBRmMNSm6LGjRZNqRL8Q1GOMrHxzyys"
}


variable "instance_type" {
  description = "Type of Ec2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_pair" {
  description = "key pair for instance"
  type        = string
  default     = "abc"
}

variable "vpc_cidr" {
  description = "cidr block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
        description = "Name of VPC"
        type        = string
        default     = "Cloud-VPC"
}

variable "subnet_cidr_public_1" {
	description = "CIDR block for public subnet 1"
	type	    = string
	default     = "10.0.1.0/24"
}

variable "public_subnet_1_name" {
  type        = string
  description = "Name for the public subnet 1"
  default     = "Public-Cloud1"
}

variable "availability_zone_1" {
  type        = string
  description = "The Availability Zone for the public subnet 1"
  default     = "ap-southeast-1a" 
}


variable "subnet_cidr_public_2" {
	description = "CIDR block for public subnet 2"
	type	    = string
	default     = "10.0.2.0/24"
}

variable "public_subnet_2_name" {
  type        = string
  description = "Name for the public subnet 2"
  default     = "Public-Cloud2"
}

variable "availability_zone_2" {
  type        = string
  description = "The Availability Zone for the public subnet 2"
  default     = "ap-southeast-1b" 
}

variable "subnet_cidr_private_1" {
	description = "CIDR block for private subnet 1"
	type	    = string
	default     = "10.0.3.0/24"
}

variable "private_subnet_1_name" {
  type        = string
  description = "Name for the private subnet 1"
  default     = "Private-Cloud1"
}

variable "subnet_cidr_private_2" {
	description = "CIDR block for private subnet 2"
	type	    = string
	default     = "10.0.4.0/24"
}

variable "private_subnet_2_name" {
  type        = string
  description = "Name for the private subnet 2"
  default     = "Private-Cloud2"
}


variable "availability_zone_3" {
  type        = string
  description = "The Availability Zone for the private subnet 2"
  default     = "ap-southeast-1c" 
}

variable "internet_gateway_name" {
  type = string
  description = "Name of the Internet Gateway"
  default = "cloud-igw"
}

variable "allow_all_ip" {
  type = string
  description = "For allowing all i addresses"
  default = "0.0.0.0/0"
}

variable "public_route_table_name" {
  type        = string
  description = "Name for the public route table"
  default     = "cloud-public-RT"
}

variable "nat_gateway_name" {
  type = string
  description = "Name of the NAT Gateway"
  default = "cloud-NAT"
}

variable "private_route_table_name" {
  type        = string
  description = "Name for the private route table"
  default     = "cloud-private-RT"
}


variable "frontend_security_group_name" {
  type        = string
  description = "Name for the Frontend security group"
  default     = "FrontendSecurityGroup"
}

variable "ssh_port" {
  type        = number
  description = "SSH port number"
  default     = 22
}

variable "tcp_protocol" {
  type = string
  description = "Tcp protocol"
  default = "tcp"
}

variable "frontend_ami_id" {
  description = "AMI ID for the frontend instance"
  type        = string
  default     = "ami-04c401fa961fbfdda" 
}

variable "frontend_name" {
  description = "Name for the frontend instance"
  type        = string
  default     = "FrontendInstance"
}

variable "backend_security_group_name" {
  type        = string
  description = "Name for the Backend security group"
  default     = "BackendSecurityGroup"
}

variable "backend_ami_id" {
  description = "AMI ID for the backend instance"
  type        = string
  default     = "ami-0b79bb0ef09eb0fe2"  
}

variable "backend_name" {
  description = "Name for the Backend instance"
  type        = string
  default     = "BackendInstance"
}

variable "database_security_group_name" {
  type        = string
  description = "Name for the Database security group"
  default     = "DatabaseSG"
}

variable "database_ami_id" {
  description = "AMI ID for the database instance"
  type        = string
  default     = "ami-0fc98e06ffb6551f5"
}

variable "database_name" {
  description = "Name for the Database instance"
  type        = string
  default     = "DatabaseInstance"
}
