provider "aws" {
  region = "ap-south-1"
}

#########################
# VPC (Class C range)
#########################

resource "aws_vpc" "class_c_vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "class-c-vpc"
  }
}

#########################
# Public Subnet
#########################

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.class_c_vpc.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "class-c-public-subnet"
  }
}

#########################
# Internet Gateway
#########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.class_c_vpc.id

  tags = {
    Name = "class-c-igw"
  }
}

#########################
# Route Table for Public Subnet
#########################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.class_c_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "class-c-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

