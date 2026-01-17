# --------------------------------
# ALB Security Group (Public)
# --------------------------------
resource "aws_security_group" "alb" {
  name        = "alb-sg-${var.tags["Environment"]}"
  description = "Allow HTTP/HTTPS from internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "alb-sg-${var.tags["Environment"]}"
      Tier = "public"
    }
  )
}

# --------------------------------
# App Security Group (Private)
# --------------------------------
resource "aws_security_group" "app" {
  name        = "app-sg-${var.tags["Environment"]}"
  description = "Allow traffic only from ALB"
  vpc_id      = var.vpc_id

  ingress {
    description     = "From ALB"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "app-sg-${var.tags["Environment"]}"
      Tier = "app"
    }
  )
}

# --------------------------------
# Data Security Group (Private / Restricted)
# --------------------------------
resource "aws_security_group" "data" {
  name        = "data-sg-${var.tags["Environment"]}"
  description = "Allow DB access only from app layer"
  vpc_id      = var.vpc_id

  ingress {
    description     = "From App layer"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = "data-sg-${var.tags["Environment"]}"
      Tier = "data"
    }
  )
}
