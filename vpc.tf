resource "aws_vpc" "code_test" {
    cidr_block = "10.2.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
    tags = {
      Name = "main"
    } 
}
