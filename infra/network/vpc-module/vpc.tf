resource "aws_vpc" "example_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(local.common_tags, {
    name = local.vpc
  })
}

//Vpc Flow logs
resource "aws_flow_log" "example_flow_log" {
  log_destination      = aws_s3_bucket.example_vpc_flow_logs_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.example_vpc.id
}

resource "aws_s3_bucket" "example_vpc_flow_logs_bucket" {
  bucket = local.bucket_flowlog
}

resource "aws_s3_bucket_public_access_block" "exameple_vpc_flow_logs_bucket_publicc_acces_block" {
  bucket                  = aws_s3_bucket.example_vpc_flow_logs_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_versioning" "example_s3_bucket_versioning" {
  bucket = aws_s3_bucket.example_vpc_flow_logs_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

// Public Subnets

resource "aws_subnet" "example_public_subnets" {
  vpc_id            = aws_vpc.example_vpc.id
  for_each          = local.public_subnets
  cidr_block        = each.value.cidr
  availability_zone = "${local.region}${each.value.az_suffix}"

  tags = merge(local.common_tags, {
    Name = each.value.name
  })
  map_public_ip_on_launch = true

}

// Private Subnets

resource "aws_subnet" "example_private_subnets" {
  vpc_id            = aws_vpc.example_vpc.id
  for_each          = local.private_subnets
  cidr_block        = each.value.cidr
  availability_zone = "${local.region}${each.value.az_suffix}"

  tags = merge(local.common_tags, {
    Name = each.value.name
  })

  map_public_ip_on_launch = false
}


// Isolated Subnets
resource "aws_subnet" "example_isolated_subnets" {
  vpc_id            = aws_vpc.example_vpc.id
  for_each          = local.isolated_subnets
  cidr_block        = each.value.cidr
  availability_zone = "${local.region}${each.value.az_suffix}"

  tags = merge(local.common_tags, {
    Name = each.value.name
  })
  map_public_ip_on_launch = false
}

//Internet Gateway
resource "aws_internet_gateway" "example_internet_gateway" {
  vpc_id = aws_vpc.example_vpc.id

}

//Nat Gateway
resource "aws_eip" "example_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "example_nat_gateway" {
  subnet_id         = aws_subnet.example_public_subnets[keys(aws_subnet.example_public_subnets)[0]].id
  allocation_id     = aws_eip.example_eip.id
  connectivity_type = "public"
}
