variable "folder_name" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "annotations" {
  type    = map(string)
  default = {}
}

variable "datasource_uid" {
  type    = string
  default = ""
}

variable "static_rule_groups" {
  type = any
}

variable "rule_groups" {
  type = any
}

locals {
  default_query_time_range = {
    from = 300
    to   = 0
  }
  expression_datasource_uid = -100
}
