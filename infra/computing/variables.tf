variable "desired_count" {
  type        = number
  default     = 1
  description = "Number of desired tasks"
}

variable "private_subnets" {
  type        = list()
  description = "List of Private Subnets"
}

variable "security_group_ecs" {
  type        = string
  description = ""
}

variable "container_cpu" {
  type    = number
  default = 512
}

variable "container_memory" {
  type    = number
  default = 512
}
