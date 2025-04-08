// S3 VPCE
resource "aws_vpc_endpoint" "example_s3_vpce" {
  service_name      = "com.amazon.aws.${local.region}.s3"
  vpc_id            = aws_vpc.example_vpc.id
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.example_private_table_route.id]
}

//SSM Endpoints

resource "aws_vpc_endpoint" "example_ssm_vpce" {
  service_name      = "com.amazonaws.${local.region}.ssm"
  vpc_id            = aws_vpc.example_vpc.id
  vpc_endpoint_type = "Interface"
  subnet_ids        = [for subnet in aws_subnet.example_private_subnets : subnet.id]
}

//SSMMESSAGES Endpoints

resource "aws_vpc_endpoint" "example_ssmmessages_vpce" {
  service_name      = "com.amazonaws.${local.region}.ssmmessages"
  vpc_id            = aws_vpc.example_vpc.id
  vpc_endpoint_type = "Interface"
  subnet_ids        = [for subnet in aws_subnet.example_private_subnets : subnet.id]
}

