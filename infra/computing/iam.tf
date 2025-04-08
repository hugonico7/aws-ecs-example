resource "aws_iam_role" "example_task_execution_role" {
  name = local.iam_task_execution_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:Assumerole"
      },
    ]
  })

}

resource "aws_iam_role_policy" "example_task_execution_policy" {

  name = local.iam_policy_task_execution_role
  role = aws_iam_role.example_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = "arn:aws:secretsmanager:${local.region}:${data.aws_caller_identity.current.account_id}:secret/${local.project}-*-${local.environment}*"
      }
    ]
  })
}

resource "aws_iam_role" "example_task_definition_role" {
  name = local.iam_taskdef_role

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:Assumerole"
      },
    ]
  })
}

resource "aws_iam_role_policy" "example_task_definition_policy" {

  name = local.iam_policy_taskdef_role
  role = aws_iam_role.example_task_definition_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_app_bucket}",
          "arn:aws:s3:::${var.s3_app_bucket}/*"
        ]
      }
    ]
  })
}
