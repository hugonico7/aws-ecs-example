locals {
  project     = "example"
  environment = "dev"
  region      = "eu-west-1"
}
locals {
  // Resource names
  alb            = "${local.project}-alb-${local.environment}-${local.region}"
  tg             = "${local.project}-tg-${local.environment}-${local.region}"
  s3_bucket_logs = "${local.project}-alb-logs-${local.environment}-${local.region}"
}
locals {
  //tags 
  common_tags = {
    project     = local.project
    environment = local.environment
  }
}
