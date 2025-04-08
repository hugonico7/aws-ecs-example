locals {
  project     = "example"
  environment = "dev"
  region      = "eu-west-1"
}
locals {
  // Resource names
  bucket_files               = "${local.project}-bucket-files-${local.environment}-${local.region}"
  rds_cluster                = "${local.project}-aurora-rds-cluster-${local.environment}-${local.region}"
  rds_aurora_db              = "${local.project}-aurora-db-${local.environment}-${local.region}"
  rds_aurora_subnet_group    = "${local.project}-subnet-group-${local.environment}-${local.region}"
  rds_aurora_parameter_group = "${local.project}-parameter-group-${local.environment}-${local.region}"
  rds_aurora_writer          = "${local.project}-aurora-writer-${local.environment}-${local.region}"
  rds_aurora_reader          = "${local.project}-aurora-reader-${local.environment}-${local.region}"

}
locals {
  //tags 
  common_tags = {
    project     = local.project
    environment = local.environment
  }
}
