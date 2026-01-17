output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "Public route table ID"
}

output "private_route_table_id" {
  value       = aws_route_table.private.id
  description = "Private route table ID"
}
