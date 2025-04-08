variable "vpc_cidr_block" {
  default     = "172.168.0.0/16"
  description = ""
  type        = string
}

variable "vpc_public_subnet1a" {
  default     = "172.168.1.0/16"
  description = ""
  type        = string
}

variable "vpc_public_subnet2b" {
  default     = "172.168.2.0/16"
  description = ""
  type        = string
}

variable "vpc_private_subnet1a" {
  default     = "172.168.3.0/16"
  description = ""
  type        = string
}

variable "vpc_private_subnet2b" {
  default     = "172.168.4.0/16"
  description = ""
  type        = string
}

variable "vpc_isolated_subnet1a" {
  default     = "172.168.5.0/16"
  description = ""
  type        = string
}

variable "vpc_isolated_subnet2b" {
  default     = "172.168.6.0/16"
  description = ""
  type        = string
}
