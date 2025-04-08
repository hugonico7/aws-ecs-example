output "vpcId" {
  value       = aws_vpc.example_vpc.id
  description = "VPC Id value"
}

output "SGAlbId" {
  value       = aws_security_group.example_alb_sg.id
  description = "ALB SG Id value"
}

output "SGEcsId" {
  value       = aws_security_group.example_ecs_sg.id
  description = "ECS SG Id value"
}

output "SGRdsId" {
  value       = aws_security_group.example_rds_sg.id
  description = "ECS SG Id value"
}

output "PublicSubnets" {
  value       = aws_subnet.example_public_subnets
  description = "Public Subnets"
}

output "PrivateSubnets" {
  value       = aws_subnet.example_private_subnets
  description = "Private Subnets"
}

output "IsolatedSubnets" {
  value       = aws_subnet.example_isolated_subnets.id
  description = "Isolated Subnets"
}

