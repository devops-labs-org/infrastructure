########################################
# Public Subnets
########################################
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "public-${var.availability_zones[count.index]}"
      Tier = "public"
    }
  )
}

########################################
# Application Subnets
########################################
resource "aws_subnet" "app" {
  count = length(var.app_subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.app_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    {
      Name = "app-${var.availability_zones[count.index]}"
      Tier = "application"
    }
  )
}

########################################
# Data Subnets (Future-ready)
########################################
resource "aws_subnet" "data" {
  count = length(var.data_subnet_cidrs)

  vpc_id            = var.vpc_id
  cidr_block        = var.data_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    {
      Name = "data-${var.availability_zones[count.index]}"
      Tier = "data"
    }
  )
}
