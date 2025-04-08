resource "aws_ecs_cluster" "example_ecs_cluster" {
  name = local.ecs_cluster

  setting {
    name  = "containerInsights"
    value = "enhanced"
  }
}

resource "aws_ecs_cluster_capacity_providers" "example_ecs_cluster_capacity_provider" {
  cluster_name       = aws_ecs_cluster.example_ecs_cluster.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_service" "example_ecs_service" {
  name                          = local.ecs_servcice
  cluster                       = aws_ecs_cluster.example_ecs_cluster.id
  availability_zone_rebalancing = "ENABLED"
  desired_count                 = var.desired_count
  enable_ecs_managed_tags       = true
  enable_execute_command        = true
  force_new_deployment          = true
  propagate_tags                = "SERVICE"


  network_configuration {
    subnets         = var.private_subnets
    security_groups = [var.security_group_ecs]
  }

  deployment_circuit_breaker {
    rollback = true
    enable   = true
  }

  deployment_controller {
    type = "ECS"
  }

}

resource "aws_ecs_task_definition" "example_task_definition" {

  family                   = local.ecs_taskdef
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.example_task_definition_role.arn
  execution_role_arn       = aws_iam_role.example_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "${local.ecs_taskdef_container}"
      image     = ""
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      environment = [
        {
          name  = "APP_ENV"
          value = local.environment
        }
      ]
      secrets = [
        {
          name      = "APP_TOKEN"
          valueFrom = aws_secretsmanager.arn
        }
      ]
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:80/health || exit 1"]
        interval    = 30
        retries     = 3
        timeout     = 5
        startPeriod = 10
      }
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-create-group  = true
          awslogs-group         = "/ecs/${local.ecs_taskdef}"
          awslogs-region        = local.region
          awslogs-stream-prefix = "ecs"
        }
      }
      linuxParameters = {
        initProcessEnabled = true
      }
    }
  ])


}
