resource "aws_network_acl" "example_network_acl" {
  vpc_id = aws_vpc.example_vpc.id
  subnet_ids = flatten([
    [for subnet in aws_subnet.example_public_subnets : subnet.id],
    [for subnet in aws_subnet.example_private_subnets : subnet.id],
    [for subnet in aws_subnet.example_isolated_subnets : subnet.id]
  ])
}

resource "aws_network_acl_rule" "example_allow_all_vpc_traffic" {
  network_acl_id = aws_network_acl.example_network_acl.id
  cidr_block     = aws_vpc.example_vpc.cidr_block
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  egress         = false
}

resource "aws_network_acl_rule" "example_deny_custom_tcp" {
  network_acl_id = aws_network_acl.example_network_acl.id
  cidr_block     = "0.0.0.0/0"
  rule_number    = 130
  rule_action    = "deny"
  protocol       = "-1"
  egress         = false
  from_port      = 20
  to_port        = 22
}

resource "aws_network_acl_rule" "example_deny_mysql" {
  network_acl_id = aws_network_acl.example_network_acl.id
  cidr_block     = "0.0.0.0/0"
  rule_number    = 140
  rule_action    = "deny"
  protocol       = "-1"
  egress         = false
  from_port      = 3306
  to_port        = 3306
}

resource "aws_network_acl_rule" "example_deny_RDP" {
  network_acl_id = aws_network_acl.example_network_acl.id
  cidr_block     = "0.0.0.0/0"
  rule_number    = 150
  rule_action    = "deny"
  protocol       = "-1"
  egress         = false
  from_port      = 3389
  to_port        = 3389
}


resource "aws_network_acl_rule" "example_deny_postgres" {
  network_acl_id = aws_network_acl.example_network_acl.id
  cidr_block     = "0.0.0.0/0"
  rule_number    = 170
  rule_action    = "deny"
  protocol       = "-1"
  egress         = false
  from_port      = 5432
  to_port        = 5432
}

resource "aws_network_acl_rule" "example_all_ingres_traffic" {
  network_acl_id = aws_network_acl.example_network_acl.id
  cidr_block     = "0.0.0.0/0"
  rule_number    = 9999
  rule_action    = "allow"
  protocol       = "-1"
  egress         = false
}

resource "aws_network_acl_rule" "example_all_egress_traffic" {
  network_acl_id = aws_network_acl.example_network_acl.id
  cidr_block     = "0.0.0.0/0"
  rule_number    = 100
  rule_action    = "allow"
  protocol       = "-1"
  egress         = true
}
