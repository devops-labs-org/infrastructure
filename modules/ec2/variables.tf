variable "subnet_id" {
  description = "Subnet ID for validation EC2"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for validation EC2"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}
