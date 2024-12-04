variable "region" {
        description = "The AWS region where my resources will be created"
        type        = string
        default     = "ap-southeast-1"
}

variable "access_key" {
        description = "access_key"
        type        = string
        default     = "AKIATTSKFVUKOQNPJ77D"
}

variable "secret_key" {
        description = "Secret access key"
        type        = string
        default     = "nfJJKyCNYJBRmMNSm6LGjRZNqRL8Q1GOMrHxzyys"

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

variable "ami_id" {
  description = "ami id for workspace instances"
  type        = string
  default     = "ami-047126e50991d067b"
}


