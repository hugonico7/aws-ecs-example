variable "domain_list" {
  type        = list()
  description = "List of strings"
}

variable "certificate_arn" {
  type        = string
  description = ""
}

variable "waf_arn" {
  type        = string
  description = ""
}

variable "alb_dnsname" {
  type        = string
  description = ""
}
variable "custom_header" {
  type        = string
  description = ""

}

variable "bucket_files_regional_domain_name" {
  type = string
}
