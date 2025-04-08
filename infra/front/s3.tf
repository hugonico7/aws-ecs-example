resource "aws_s3_bucket" "example_s3_bucket_front" {
  bucket = local.s3_bucket_front
}

resource "aws_s3_bucket_public_access_block" "example_s3_bucket_front_publicc_acces_block" {
  bucket                  = aws_s3_bucket.example_s3_bucket_front.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "example_s3_bucket_front_versioning" {
  bucket = aws_s3_bucket.example_s3_bucket_front.id
  versioning_configuration {
    status = "enabled"
  }
}

resource "aws_s3_bucket" "example_s3_bucket_cloudfront_logs" {
  bucket = local.s3_bucket_logs
}

resource "aws_s3_bucket_public_access_block" "example_s3_bucket_logs_publicc_acces_block" {
  bucket                  = aws_s3_bucket.example_s3_bucket_cloudfront_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "example_s3_bucket_logs_versioning" {
  bucket = aws_s3_bucket.example_s3_bucket_cloudfront_logs
  versioning_configuration {
    status = "enabled"
  }
}
