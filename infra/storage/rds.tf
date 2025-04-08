resource "aws_db_subnet_group" "example_db_subnet_group" {
  name       = local.rds_aurora_subnet_group
  subnet_ids = var.isolated_subnets
}

resource "aws_rds_cluster_parameter_group" "example_rds_cluster_parameter_group" {
  name        = local.rds_aurora_parameter_group
  family      = "aurora-postgresql"
  description = "RDS default cluster parameter group"

  parameter {
    name  = "general_log"
    value = "1"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "server_audit_logging"
    value = "1"
  }
  parameter {
    name  = "server_audit_events"
    value = "CONNECT,QUERY"
  }
}

resource "aws_rds_cluster" "example_rds_cluster" {
  cluster_identifier              = local.rds_cluster
  engine                          = "aurora-postgresql"
  engine_version                  = "13.4"
  availability_zones              = ["${local.region}a", "${local.region}b", "${local.region}c"]
  database_name                   = local.rds_aurora_db
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example_rds_cluster_parameter_group.name
  master_username                 = "admin_${local.project}"
  manage_master_user_password     = true
  storage_encrypted               = true
  vpc_security_group_ids          = [var.security_group_rds_id]
  db_subnet_group_name            = aws_db_subnet_group.example_db_subnet_group.name
  backup_retention_period         = 7
  deletion_protection             = true
}

resource "aws_rds_cluster_instance" "example_aurora_instances" {
  for_each = {
    "writer" = local.rds_aurora_writer
    "reader" = local.rds_aurora_reader
  }
  identifier          = each.value
  cluster_identifier  = aws_rds_cluster.example_rds_cluster.id
  instance_class      = "db.r6g.large"
  engine              = "aurora-postgresql"
  publicly_accessible = false
}


