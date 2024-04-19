# Internet Access VPC

resource "aws_vpc" "code_test" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name = "main"
  }
}

# Subnet Details

resource "aws_subnet" "public-subnets" {
  vpc_id                  = aws_vpc.code_test.id
  count                   = length(var.public_subnet_cidrs)
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name = "public-subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private-subnets" {
  vpc_id                  = aws_vpc.code_test.id
  count                   = length(var.private_subnet_cidrs)
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = "true"
  tags = {
    Name = "private-subnet ${count.index + 1}"
  }
}


# Internet Gateway

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.code_test.id
  tags = {
    Name = "main-gw"
  }
}

# Route Table

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.code_test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
  tags = {
    Name = "Code-RT"
  }
}

# Public Subnet Associate to Internet 

resource "aws_route_table_association" "public_subnet-associate" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public-subnets[*].id, count.index)
  route_table_id = aws_route_table.second_rt.id
}