resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "igw-${var.tags["Environment"]}"
    }
  )
}

# ----------------------------
# Public Route Table
# ----------------------------
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.tags,
    {
      Name = "public-rt-${var.tags["Environment"]}"
      Tier = "public"
    }
  )
}

# ----------------------------
# Private Route Table
# ----------------------------
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  # NAT route will be added later (Step 7)
  dynamic "route" {
    for_each = var.nat_gateway_id == null ? [] : [1]
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = var.nat_gateway_id
    }
  }

  tags = merge(
    var.tags,
    {
      Name = "private-rt-${var.tags["Environment"]}"
      Tier = "private"
    }
  )
}

# ----------------------------
# Data Route Table (NO INTERNET)
# ----------------------------
resource "aws_route_table" "data" {
  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "data-rt-${var.tags["Environment"]}"
      Tier = "data"
    }
  )
}

# --------------------------------
# Public Route Table Associations
# --------------------------------
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_ids)

  subnet_id      = var.public_subnet_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# --------------------------------
# App Route Table Associations
# --------------------------------
resource "aws_route_table_association" "app" {
  count = length(var.app_subnet_ids)

  subnet_id      = var.app_subnet_ids[count.index]
  route_table_id = aws_route_table.private.id
}

# --------------------------------
# Data Route Table Associations
# --------------------------------
resource "aws_route_table_association" "data" {
  count = length(var.data_subnet_ids)

  subnet_id      = var.data_subnet_ids[count.index]
  route_table_id = aws_route_table.data.id
}
