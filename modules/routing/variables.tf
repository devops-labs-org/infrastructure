variable "vpc_id" {
  description = "VPC ID to attach routing resources"
  type        = string
}

variable "nat_gateway_id" {
  description = "NAT Gateway ID"
  type        = string
  default     = null
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "app_subnet_ids" {
  description = "App subnet IDs"
  type        = list(string)
}

variable "data_subnet_ids" {
  description = "Data subnet IDs"
  type        = list(string)
}
