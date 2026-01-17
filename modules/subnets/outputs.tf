########################################
# Public Subnets Outputs
########################################
output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = aws_subnet.public[*].id
}

########################################
# Application Subnets Outputs
########################################
output "app_subnet_ids" {
  description = "IDs of application subnets"
  value       = aws_subnet.app[*].id
}

########################################
# Data Subnets Outputs
########################################
output "data_subnet_ids" {
  description = "IDs of data subnets"
  value       = aws_subnet.data[*].id
}
