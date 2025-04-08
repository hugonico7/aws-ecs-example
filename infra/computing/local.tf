locals {
  project     = "example"
  environment = "dev"
  region      = "eu-west-1"
}
locals {
  // Resource names
  ecs_cluster                    = "${local.project}-cluster-${local.environment}-${local.region}"
  ecs_servcice                   = "${local.project}-api-service-${local.environment}-${local.region}"
  ecs_taskdef                    = "${local.project}-api-taskdef-${local.environment}-${local.region}"
  ecs_taskdef_container          = "${local.project}-api-conatiner-${local.environment}-${local.region}"
  iam_task_execution_role        = "${local.project}-api-task-execution-role-${local.environment}-${local.region}"
  iam_policy_task_execution_role = "${local.project}-api-policy-task-execution-role-${local.environment}-${local.region}"
  iam_taskdef_role               = "${local.project}-api-task-definition-role-${local.environment}-${local.region}"
  iam_policy_taskdef_role        = "${local.project}-api-policy-task-definition-role-${local.environment}-${local.region}"

}
locals {
  //tags 
  common_tags = {
    project     = local.project
    environment = local.environment
  }
}
