resource "aws_cloudfront_distribution" "example_cloudfront_distribution" {
  enabled             = true
  default_root_object = "index.html"
  aliases             = var.domain_list

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }


  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  price_class = "PriceClass_100"

  logging_config {
    include_cookies = true
    bucket          = aws_s3_bucket.example_s3_bucket_cloudfront_logs.id
    prefix          = "cloudfront/${local.cloudfront}"
  }

  http_version = "http2and3"

  web_acl_id = var.waf_arn

  origin {
    origin_access_control_id = aws_cloudfront_origin_access_control.example_s3_front_oac.id
    domain_name              = aws_s3_bucket.example_s3_bucket_front.bucket_regional_domain_name
    origin_id                = "S3BucketFront"

  }

  origin {
    origin_access_control_id = aws_cloudfront_origin_access_control.example_s3_files_oac.id
    domain_name              = var.bucket_files_regional_domain_name
    origin_id                = "S3BucketFiles"

  }


  origin {

    domain_name = var.alb_dnsname
    origin_id   = "ALBOrigin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "x-Custom-Header"
      value = var.custom_header
    }
  }

  default_cache_behavior {
    target_origin_id           = "S3BucketFront"
    viewer_protocol_policy     = "redirect-to-https"
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD"]
    cache_policy_id            = data.aws_cloudfront_cache_policy.caching_optimized
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.cors_s3_origin
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.security_headers_policy
  }

  ordered_cache_behavior {
    path_pattern               = "/mcs/*"
    target_origin_id           = "ALBOrigin"
    viewer_protocol_policy     = "redirect-to-https"
    allowed_methods            = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "DELETE", "PATCH"]
    cached_methods             = ["GET", "HEAD"]
    cache_policy_id            = data.aws_cloudfront_cache_policy.caching_disabled
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.all_viewer
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.security_headers_policy
    compress                   = false
  }


  ordered_cache_behavior {
    path_pattern               = "/files/*"
    target_origin_id           = "S3BucketFiles"
    viewer_protocol_policy     = "redirect-to-https"
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD"]
    cache_policy_id            = data.aws_cloudfront_cache_policy.caching_optimized
    origin_request_policy_id   = data.aws_cloudfront_origin_request_policy.cors_s3_origin
    response_headers_policy_id = data.aws_cloudfront_response_headers_policy.security_headers_policy
  }

}

resource "aws_cloudfront_origin_access_control" "example_s3_front_oac" {
  name        = local.s3_front_oac
  description = "Acces control to s3 Bucket front"

  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_control" "example_s3_files_oac" {
  name                              = local.s3_files_oac
  description                       = "Acces control to s3 Bucket files"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

data "aws_cloudfront_cache_policy" "caching_optimized" {
  name = "Managed-CachingOptimized"
}

data "aws_cloudfront_cache_policy" "caching_disabled" {
  name = "Managed-CachingDisabled"
}

data "aws_cloudfront_origin_request_policy" "cors_s3_origin" {
  name = "Managed-CORS-S3Origin"
}

data "aws_cloudfront_origin_request_policy" "all_viewer" {
  name = "Managed-AllViewer"
}

data "aws_cloudfront_response_headers_policy" "security_headers_policy" {
  name = "SecurityHeadersPolicy"
}
