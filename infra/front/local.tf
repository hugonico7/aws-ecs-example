locals {
  project     = "example"
  environment = "dev"
  region      = "eu-west-1"
}
locals {
  // Resource names
  s3_bucket_front = "${local.project}-s3-bucket-front-${local.environment}-${local.region}"
  s3_bucket_logs  = "${local.project}-s3-bucket-logs-${local.environment}-${local.region}"
  cloudfront      = "${local.project}-cloudfront-${local.environment}"
  s3_front_oac    = "${local.project}-s3-bucket-front-oac-${local.environment}"
  s3_files_oac    = "${local.project}-s3-bucket-files-oac-${local.environment}"

}
locals {
  //tags 
  common_tags = {
    project     = local.project
    environment = local.environment
  }
}
