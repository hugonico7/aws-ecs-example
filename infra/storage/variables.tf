variable "isolated_subnets" {
  type        = list()
  description = "List of Isolated Subnets"
}

variable "security_group_rds_id" {
  type = string
}

variable "db_instance_class" {
  type    = string
  default = ""
}
