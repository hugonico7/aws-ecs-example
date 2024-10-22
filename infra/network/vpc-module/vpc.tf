resource "aws_vpc" "main" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_support   = true
  enable_dns_hostnames = true
}

// Public Subnets

resource "aws_subnet" "public-subnet1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc-public-subnet1a
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "public-subnet2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc-public-subnet2b
  availability_zone = "eu-west-1b"
}

// Private Subnets

resource "aws_subnet" "private-subnet1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc-private-subnet1a
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "private-subnet2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc-private-subnet2b
  availability_zone = "eu-west-1b"
}

// Isolated Subnets

resource "aws_subnet" "isolated-subnet1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc-isolated-subnet1a
  availability_zone = "eu-west-1a"
}

resource "aws_subnet" "isolated-subnet2b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.vpc-isolated-subnet2b
  availability_zone = "eu-west-1b"
}

//Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

//Nat Gateway
resource "aws_eip" "main" {
  domain = "vpc"
}
resource "aws_nat_gateway" "main" {
  subnet_id         = aws_subnet.public-subnet1a.id
  allocation_id     = aws_eip.main.id
  connectivity_type = "public"
}
