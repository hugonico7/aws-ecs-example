locals {
  project     = "example"
  environment = "dev"
  region      = "eu-west-1"
}
locals {
  // Resource names and data
  waf = "${local.project}-waf-acl-${local.environment}-${local.region}"
}
locals {
  //tags 
  common_tags = {
    project     = local.project
    environment = local.environment
  }
}
