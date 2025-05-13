variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default = "172.16.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default = ["172.16.16.0/24", "172.16.24.0/24"]
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  type        = number
  default = 2
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default = ["172.16.0.0/24", "172.16.8.0/24"]
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  type        = number
  default = 2
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default = "demo-vpc"
}

variable "igw_name" {
  description = "Name for the Internet Gateway"
  type        = string
  default = "igw"
}