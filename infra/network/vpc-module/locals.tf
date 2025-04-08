locals {
  project     = "example"
  environment = "dev"
  region      = "eu-west-1"
}
locals {
  // Resource names and data
  sg_alb = "${local.project}-sg-alb-${local.environment}-${local.region}"
  sg_ecs = "${local.project}-sg-ecs-${local.environment}-${local.region}"
  sg_rds = "${local.project}-sg-rds-${local.environment}-${local.region}"
  vpc    = "${local.project}-vpc-${local.environment}-${local.region}"
  public_subnets = {
    "subnet1a" = { cidr = var.vpc_public_subnet1a, az_suffix = "a", name = "${local.project}-public-subnet-1a-${local.environment}-${local.region}" }
    "subnet2b" = { cidr = var.vpc_public_subnet2b, az_suffix = "b", name = "${local.project}-public-subnet-2b-${local.environment}-${local.region}" }
  }
  private_subnets = {
    "subnet1a" = { cidr = var.vpc_private_subnet1a, az_suffix = "a", name = "${local.project}-private-subnet-1a-${local.environment}-${local.region}" }
    "subnet2b" = { cidr = var.vpc_private_subnet2b, az_suffix = "b", name = "${local.project}-private-subnet-2b-${local.environment}-${local.region}" }
  }
  isolated_subnets = {
    "subnet1a" = { cidr = var.vpc_isolated_subnet1a, az_suffix = "a", name = "${local.project}-isolated-subnet-1a-${local.environment}-${local.region}" }
    "subnet2b" = { cidr = var.vpc_isolated_subnet2b, az_suffix = "b", name = "${local.project}-isolated-subnet-2b-${local.environment}-${local.region}" }
  }
  bucket_flowlog = "${local.project}-bucket-flow-log-${local.environment}-${local.region}"
}
locals {
  //tags 
  common_tags = {
    project     = local.project
    environment = local.environment
  }
}
