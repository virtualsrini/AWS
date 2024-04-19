
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.2.4.0/24", "10.2.5.0/24", "10.2.6.0/24"]
}

variable "availability_zone" {
  type        = list(string)
  description = "Availibility Zone"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cidr_block" {
  default = "10.2.0.0/16"
}