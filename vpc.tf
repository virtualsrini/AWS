# Internet Access VPC

resource "aws_vpc" "code_test" {
    cidr_block = "10.2.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
    tags = {
      Name = "main"
    } 
}

# Subnet Details

resource "aws_subnet" "main_public-1" {
  vpc_id = "aws_vpc.code_testd.id"
  cidr_block = "10.2.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "main_public-1"
  }  
}

resource "aws_subnet" "main_public-2" {
  vpc_id = "aws_vpc.code_test.id"
  cidr_block = "10.2.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "main_public-2"
  }  
}

resource "aws_subnet" "main_private-1" {
  vpc_id = "aws_vpc.code_test.id"
  cidr_block = "10.2.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = "false"
  tags = {
    Name = "main_private-1"
  }  
}

resource "aws_subnet" "main_private-2" {
  vpc_id = "aws_vpc.code_test.id"  
  cidr_block = "10.2.4.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "fal
  tags = {
    Name = "main_private-2"
  }
}