resource "aws_s3_bucket" "example_alb_logs_bucket" {
  bucket = local.s3-bucket-logs
}

resource "aws_s3_bucket_public_access_block" "exameple_vpc_flow_logs_bucket_publicc_acces_block" {
  bucket                  = aws_s3_bucket.example_alb_logs_bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "example_s3_bucket_versioning" {
  bucket = aws_s3_bucket.example_alb_logs_bucket
  versioning_configuration {
    status = "enabled"
  }
}
resource "aws_lb" "example_alb" {
  name                       = local.alb
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.sg_alb_id]
  subnets                    = var.public_subnets
  drop_invalid_header_fields = true
  desync_mitigation_mode     = "strictest"

  access_logs {
    bucket  = aws_s3_bucket.example_alb_logs_bucket
    prefix  = "${local.s3_bucket_logs}/access_logs/"
    enabled = true
  }

  connection_logs {
    bucket  = aws_s3_bucket.example_alb_logs_bucket
    prefix  = "${local.s3_bucket_logs}/connection_logs/"
    enabled = true
  }
}

resource "aws_lb_listener" "example_alb_https_listener" {
  load_balancer_arn = aws_lb.example_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.certificate_arn
  default_action {
    type = "fixed-response"
    fixed_response {
      status_code  = "503"
      message_body = "service Unavailable"
      content_type = "text/plain"
    }
  }
}

resource "aws_lb_listener_rule" "example_alb_https_listener_rule" {
  listener_arn = aws_lb_listener.example_alb_https_listener.arn
  priority     = 1

  condition {
    path_pattern {
      values = ["/mcs"]
    }
    host_header {
      values = var.domain_list
    }
    http_header {
      http_header_name = "x-Custom-header"
      values           = [var.custom_header]
    }
  }

  action {
    type = "forward"
    forward {
      target_group {
        arn = aws_alb_target_group.example_target_group_ip.arn
      }
    }
  }
}
