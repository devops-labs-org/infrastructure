variable "vpc_id" {
  description = "VPC ID where subnets will be created"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "app_subnet_cidrs" {
  description = "CIDR blocks for application subnets"
  type        = list(string)
}

variable "data_subnet_cidrs" {
  description = "CIDR blocks for data subnets"
  type        = list(string)
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
