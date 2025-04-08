resource "aws_alb_target_group" "example_target_group_ip" {
  name        = local.tg
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
    matcher             = "200,307"
    path                = "/health"
  }
}

