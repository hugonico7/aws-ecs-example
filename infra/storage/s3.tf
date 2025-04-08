resource "aws_s3_bucket" "example_files_bucket" {
  bucket = local.bucket_files
}

resource "aws_s3_bucket_public_access_block" "exameple_files_bucket_publicc_acces_block" {
  bucket                  = aws_s3_bucket.example_files_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_versioning" "example_s3_bucket_versioning" {
  bucket = aws_s3_bucket.example_files_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

