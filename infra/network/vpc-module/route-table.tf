// Public Route Table
resource "aws_route_table" "public-table-route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "rt-association-public-subnet1a" {
  route_table_id = aws_route_table.public-table-route.id
  subnet_id      = aws_subnet.public-subnet1a.id
}

resource "aws_route_table_association" "rt-association-public-subnet2b" {
  route_table_id = aws_route_table.public-table-route.id
  subnet_id      = aws_subnet.public-subnet2b.id
}

//Private Route Table
resource "aws_route_table" "private-table-route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }
}

resource "aws_route_table_association" "rt-association-private-subnet1a" {
  route_table_id = aws_route_table.private-table-route.id
  subnet_id      = aws_subnet.private-subnet1a.id
}

resource "aws_route_table_association" "rt-association-private-subnet2b" {
  route_table_id = aws_route_table.private-table-route.id
  subnet_id      = aws_subnet.private-subnet2b.id
}

//Isolated Route Table

resource "aws_route_table" "isolated-table-route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc-cidr-block
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "rt-association-isolated-subnet1a" {
  route_table_id = aws_route_table.isolated-table-route.id
  subnet_id      = aws_subnet.isolated-subnet1a.id
}

resource "aws_route_table_association" "rt-association-isolated-subnet2b" {
  route_table_id = aws_route_table.isolated-table-route.id
  subnet_id      = aws_subnet.isolated-subnet2b.id
}

