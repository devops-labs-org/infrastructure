variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "alb_sg_id" {
  description = "ALB security group ID"
  type        = string
}

variable "app_sg_id" {
  description = "App security group ID"
  type        = string
}
