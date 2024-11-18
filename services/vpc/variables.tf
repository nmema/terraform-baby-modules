variable "aws_region" {
  description = "The AWS Region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR value"
  default     = "10.0.0.0/16"
}


variable "public_subnets_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-west-2a", "us-west-2b"]
}

variable "prefix_name" {
  type        = string
  description = "Prefix used for naming the resources"
  default     = "Terraform"
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}
