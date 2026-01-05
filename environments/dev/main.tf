############################################################
# RESERVED CIDR BLOCKS (DO NOT USE)
#
# 10.0.40.0/22  → Future AZ expansion
# 10.0.44.0/22  → Service mesh / internal load balancers
# 10.0.48.0/20  → Kubernetes pod CIDRs
# 10.0.64.0/18  → Long-term growth
#
# These CIDRs are intentionally unused to prevent
# CIDR fragmentation and allow predictable scaling.
############################################################

terraform {
  backend "s3" {
    bucket         = "terraform-state-hasini-us-east-1"
    key            = "environments/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

########################################
# VPC
########################################
module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "dev-vpc"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

########################################
# Subnets
########################################
module "subnets" {
  source = "../../modules/subnets"

  vpc_id = module.vpc.vpc_id

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]

  # Public subnets (Ingress layer)
  public_subnet_cidrs = [
    "10.0.0.0/21",   # public-az1
    "10.0.8.0/21"    # public-az2
  ]

  # Application subnets
  app_subnet_cidrs = [
    "10.0.16.0/21",  # app-az1
    "10.0.24.0/21"   # app-az2
  ]

  # Data subnets (isolated)
  data_subnet_cidrs = [
    "10.0.32.0/22",  # data-az1
    "10.0.36.0/22"   # data-az2
  ]

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

########################################
# NAT Gateway (Step 7)
########################################
module "nat" {
  source = "../../modules/nat"

  # NAT is placed in public-az1 (cost-optimized for dev)
  public_subnet_id = module.subnets.public_subnet_ids[0]

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

########################################
# Routing (IGW + Route Tables + Associations)
########################################
module "routing" {
  source = "../../modules/routing"

  vpc_id = module.vpc.vpc_id

  # Route table associations (Step 8)
  public_subnet_ids = module.subnets.public_subnet_ids
  app_subnet_ids    = module.subnets.app_subnet_ids
  data_subnet_ids   = module.subnets.data_subnet_ids

  # NAT routing for app subnets
  nat_gateway_id = module.nat.nat_gateway_id

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

########################################
# Security Groups (Step 9)
########################################
module "security_groups" {
  source = "../../modules/security-groups"

  vpc_id = module.vpc.vpc_id

  # SG chaining (ALB → App → Data)
  alb_sg_id = module.security_groups.alb_sg_id
  app_sg_id = module.security_groups.app_sg_id

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}

########################################
# IAM (for EC2 validation)
########################################
module "iam" {
  source = "../../modules/iam"
}

########################################
# Validation EC2 (Step 10)
########################################
module "validation_ec2" {
  source = "../../modules/ec2"

  subnet_id            = module.subnets.app_subnet_ids[0]
  security_group_id    = module.security_groups.app_sg_id
  iam_instance_profile = module.iam.instance_profile_name

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
