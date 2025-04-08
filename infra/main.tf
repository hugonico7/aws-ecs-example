resource "random_string" "random" {
  length  = 16
  special = true
}
module "vpc-module" {
  source                = "./network/vpc-module"
  vpc_cidr_block        = "172.16.0.0/16"
  vpc_public_subnet1a   = "172.16.16.0/20"
  vpc_public_subnet2b   = "172.16.32.0/20"
  vpc_private_subnet1a  = "172.16.48.0/20"
  vpc_private_subnet2b  = "172.16.64.0/20"
  vpc_isolated_subnet1a = "172.16.80.0/20"
  vpc_isolated_subnet2b = "172.16.96.0/20"
}

module "alb-module" {
  source          = "./network/alb-module"
  vpc_id          = module.vpc-module.vpcId
  sg_alb_id       = module.vpc-module.SGAlbId
  domain_list     = ["example.domain.com"]
  custom_header   = random_string.random.result
  public_subnets  = module.vpc-module.PublicSubnets
  certificate_arn = ""
}

module "front-module" {
  source                            = "./front"
  certificate_arn                   = ""
  custom_header                     = random_string.random.result
  domain_list                       = ["example.domain.com"]
  bucket_files_regional_domain_name = module.storage-modules.S3BucketFilesDomainName
  alb_dnsname                       = module.alb-module.AlbDnsName
  waf_arn                           = module.security-module.wafArn
}

module "computing-module" {
  source             = "./computing"
  container_cpu      = 512
  container_memory   = 1024
  desired_count      = 1
  private_subnets    = module.vpc-module.PrivateSubnets
  security_group_ecs = module.vpc-module.SGEcsId

}

module "storage-modules" {
  source                = "./storage"
  isolated_subnets      = module.vpc-module.IsolatedSubnets
  security_group_rds_id = module.vpc-module.SGRdsId
  db_instance_class     = "db.t4g.medium"
}

module "security-module" {
  source = "./security"
}
