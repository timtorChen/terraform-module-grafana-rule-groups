terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "3.7.0"
    }
  }
}

provider "grafana" {
  url  = ""
  auth = ""
}

resource "grafana_data_source" "prometheus" {
  type = "prometheus"
  name = "demo-prometheus"
  url  = ""
}

module "alert" {
  source  = "timtorChen/grafana-rule-groups/module"
  version = "0.1.0"

  folder_name        = "node"
  datasource_uid     = grafana_data_source.prometheus.uid
  static_rule_groups = yamldecode(templatefile("${path.module}/node-exporter-rules.yaml", {}))
  rule_groups        = {}
}
