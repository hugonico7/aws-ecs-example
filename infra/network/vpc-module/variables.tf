variable "vpc-cidr-block" {
  default     = "172.168.0.0/16"
  description = ""
  type        = string
}

variable "vpc-public-subnet1a" {
  default     = "172.168.1.0/16"
  description = ""
  type        = string
}

variable "vpc-public-subnet2b" {
  default     = "172.168.2.0/16"
  description = ""
  type        = string
}

variable "vpc-private-subnet1a" {
  default     = "172.168.3.0/16"
  description = ""
  type        = string
}

variable "vpc-private-subnet2b" {
  default     = "172.168.4.0/16"
  description = ""
  type        = string
}

variable "vpc-isolated-subnet1a" {
  default     = "172.168.5.0/16"
  description = ""
  type        = string
}

variable "vpc-isolated-subnet2b" {
  default     = "172.168.6.0/16"
  description = ""
  type        = string
}
