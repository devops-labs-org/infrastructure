variable "subnet_id" {
  description = "Subnet ID for validation instance"
  type        = string
}

variable "security_group_id" {
  description = "Security group for validation instance"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
