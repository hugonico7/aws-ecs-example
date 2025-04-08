// Public Route Table
resource "aws_route_table" "example_public_table_route" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_internet_gateway.id
  }
}

resource "aws_route_table_association" "example_rt_association_public_subnets" {
  for_each       = aws_subnet.example_public_subnets
  route_table_id = aws_route_table.example_public_table_route.id
  subnet_id      = each.value.id

}

//Private Route Table
resource "aws_route_table" "example_private_table_route" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example_nat_gateway.id
  }
}

resource "aws_route_table_association" "example_rt_association_private_subnets" {
  for_each       = aws_subnet.example_private_subnets
  route_table_id = aws_route_table.example_private_table_route.id
  subnet_id      = each.value.id

}

//Isolated Route Table

resource "aws_route_table" "example_isolated_table_route" {
  vpc_id = aws_vpc.example_vpc.id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "example_rt_association_isolated_subnets" {
  for_each       = aws_subnet.example_isolated_subnets
  route_table_id = aws_route_table.example_isolated_table_route.id
  subnet_id      = each.value.id
}

