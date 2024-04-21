provider "aws" {
  region = us-east-1
}

variable "ami" {
  description = "This the AMI image"
}

variable "instance_type" {
  description = "This represents the image size"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = var.instance_type
}