output "wafArn" {
  value       = aws_wafv2_web_acl.example_web_acl.arn
  description = "Waf Arn value"
}
