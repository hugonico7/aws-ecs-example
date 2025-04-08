data "aws_prefix_list" "cloudfront-prefix-list" {
  name = "com.amazonaws.global.cloudfront.origin-facing"

}

resource "aws_security_group" "example_alb_sg" {
  name        = local.sg_alb
  description = "security group alb"
  vpc_id      = aws_vpc.example_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "example_rule_allow_https" {
  security_group_id = aws_security_group.example_alb_sg.id
  description       = "allow https from cloudfront"
  prefix_list_id    = data.aws_prefix_list.cloudfront-prefix-list.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_security_group" "example_ecs_sg" {
  name        = local.sg_ecs
  description = "security group ecs"
  vpc_id      = aws_vpc.example_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "example_rule_allow_http" {
  security_group_id            = aws_security_group.example_alb_sg.id
  description                  = "allow traffic form ALB SG"
  referenced_security_group_id = aws_security_group.example_alb_sg.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_security_group" "example_rds_sg" {
  name        = local.sg_rds
  description = "security group rds"
  vpc_id      = aws_vpc.example_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "example_rule_allow_sql" {
  security_group_id = aws_security_group.example_rds_sg.id
  description       = "allow traffic from RDS SG"
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}


