variable "sg_alb_id" {
  type        = string
  description = "Security group id"
}

variable "public_subnets" {
  type        = set()
  description = "Public subnets list"
}

variable "vpc_id" {
  type        = string
  description = "Vpc Id"
}

variable "certificate_arn" {
  type        = string
  description = ""
}

variable "domain_list" {
  type        = list()
  description = "List of strings"
}

variable "custom_header" {
  type        = string
  description = ""
}
