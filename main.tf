resource "grafana_folder" "this" {
  title = var.folder_name
}

resource "grafana_rule_group" "this" {
  for_each           = { for group in var.static_rule_groups : group.name => group }
  name               = each.value.name
  folder_uid         = grafana_folder.this.uid
  interval_seconds   = each.value.interval_seconds
  disable_provenance = !try(each.value.enable_edit, false)

  dynamic "rule" {
    for_each = { for rule in each.value.rules : rule.name => rule }
    iterator = rule
    content {
      name           = rule.value.name
      condition      = rule.value.condition
      no_data_state  = rule.value.no_data_state
      exec_err_state = rule.value.exec_err_state
      for            = rule.value.for
      annotations = merge(
        rule.value.annotations,
        try(var.annotations, null),
        try(var.rule_groups.annotations, null),
        try(var.rule_groups.rule_group["${each.key}"].annotations, null),
        try(var.rule_groups.rule_group["${each.key}"].rule["${rule.key}"].annotations, null)
      )
      labels = merge(
        rule.value.labels,
        try(var.labels, null),
        try(var.rule_groups.labels, null),
        try(var.rule_groups.rule_group["${each.key}"].labels, null),
        try(var.rule_groups.rule_group["${each.key}"].rule["${rule.key}"].labels, null)
      )
      is_paused = (
        try(rule.value.pause,
          try(var.rule_groups.rule_group["${each.key}"].rule["${rule.key}"].pause,
            try(var.rule_groups.rule_group["${each.key}"].pause,
              try(var.rule_groups.pause, false)
            )
          )
        )
      )
      dynamic "notification_settings" {
        for_each = (
          try([var.rule_groups.rule_group["${each.key}"].rule["${rule.key}"].notification_settings],
            try([var.rule_groups.rule_group["${each.key}"].notification_settings],
              try([var.rule_groups.notification_settings],
                try([rule.value.notification_settings], [])
              )
            )
          )
        )
        iterator = notification_settings
        content {
          contact_point   = notification_settings.value.contact_point
          group_by        = try(notification_settings.value.group_by, null)
          group_interval  = try(notification_settings.value.group_interval, null)
          group_wait      = try(notification_settings.value.group_wait, null)
          mute_timings    = try(notification_settings.value.mute_timings, null)
          repeat_interval = try(notification_settings.value.repeat_interval, null)
        }
      }

      dynamic "data" {
        for_each = rule.value.datas
        iterator = data
        content {
          ref_id = data.value.ref_id
          datasource_uid = (
            can(data.value.model.type)
            ? local.expression_datasource_uid
            : try(data.value.datasource_uid, var.datasource_uid)
          )
          model = jsonencode(merge(data.value.model, {
            refId = data.value.ref_id,
          }))
          relative_time_range {
            from = local.default_query_time_range.from
            to   = local.default_query_time_range.to
          }
        }
      }
    }
  }
}
