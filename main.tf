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
  access_key = "AKIATTSKFVUKOQNPJ77D"
  secret_key = "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"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_public_1
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_1

  tags = {
    Name = var.public_subnet_1_name
  }
}


resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_public_2
  map_public_ip_on_launch = true
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.public_subnet_2_name
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_private_1
  availability_zone = var.availability_zone_2

  tags = {
    Name = var.private_subnet_1_name
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_private_2
  availability_zone = var.availability_zone_3

  tags = {
    Name = var.private_subnet_2_name
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = var.internet_gateway_name
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route{
     cidr_block = var.allow_all_ip
     gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
	Name = var.public_route_table_name
  }
}

resource "aws_route_table_association" "public_route_assoc_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_assoc_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_eip" "elastic_ip"{
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = aws_subnet.public_subnet_2.id

  tags = {
	Name = var.nat_gateway_name
	}
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route{
     cidr_block = var.allow_all_ip
     nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
        Name = var.private_route_table_name
  }
}

resource "aws_route_table_association" "private_route_assoc_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_route_assoc_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "frontend_sg" {
  vpc_id = aws_vpc.my_vpc.id

ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = "[0.0.0.0/0]"  
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  
    cidr_blocks = "[0.0.0.0/0]"  
  }
tags = {
    Name = var.frontend_security_group_name
  }
}


resource "aws_instance" "frontend" {
  ami           = var.frontend_ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = var.key_pair
  security_groups = [aws_security_group.frontend_sg.id]

  tags = {
    Name = var.frontend_name
  }
}

resource "aws_security_group" "backend_sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = "[0.0.0.0/0]"
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "[0.0.0.0/0]"
  }

tags = {
    Name = var.backend_security_group_name
  }
}

resource "aws_instance" "backend" {
  ami             = var.backend_ami_id
  instance_type   = var.instance_type
  key_name      = var.key_pair
  subnet_id       = aws_subnet.private_subnet_1.id  
  security_groups = [aws_security_group.backend_sg.id]
tags = {
    Name = var.backend_name
  }
}

resource "aws_security_group" "database_sg" {
  vpc_id = aws_vpc.my_vpc.id
ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = "[0.0.0.0/0]"
  }
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "[0.0.0.0/0]"
  }

  tags = {
    Name = var.database_security_group_name
  }
}
#Database instance
  resource "aws_instance" "database" {
  ami           = var.database_ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_subnet_2.id
  key_name      = var.key_pair
  security_groups = [aws_security_group.database_sg.id]

     tags = {
    Name = var.database_name
  }
}





