# ----------------------------------
# Elastic IP for NAT Gateway
# ----------------------------------
resource "aws_eip" "this" {
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "nat-eip-${var.tags["Environment"]}"
    }
  )
}

# ----------------------------------
# NAT Gateway (in public subnet)
# ----------------------------------
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.public_subnet_id

  tags = merge(
    var.tags,
    {
      Name = "nat-${var.tags["Environment"]}"
    }
  )

  depends_on = [aws_eip.this]
}
