provider "aws" {
   region = "us-east-1"
}

variable "instance_type" {
  description = "This is instance type, like nano, medium, small., etc"
}

variable "ami" {
  description = "This is AMI for the instance"
}

resource "aws_instance" "example" {
  ami = var.ami
  instance_type = var.instance_type
}