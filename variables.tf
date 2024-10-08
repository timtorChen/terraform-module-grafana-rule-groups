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

variable "pause" {
  type    = bool
  default = null
}

variable "editable" {
  type    = bool
  default = null
}

variable "notification_settings" {
  type = object({
    contact_point   = string
    group_by        = optional(list(string))
    group_interval  = optional(string)
    group_wait      = optional(string)
    mute_timings    = optional(list(string))
    repeat_interval = optional(string)
  })
  default = null
}

variable "static_rule_groups" {
  type = any
}

variable "rule_groups" {
  type    = any
  default = {}
}

locals {
  default_query_time_range = {
    from = 300
    to   = 0
  }
  expression_datasource_uid = -100
}
