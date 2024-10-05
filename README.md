# Terraform grafana rule groups module

⚠️ This project is still under development; use it with caution.

The helper module to create grafana alerts from document following rule-groups [schema](./schema.json).

## Usage

Load rule groups document with `static_rule_groups` and customize fine-grained control on each rule with `rule_groups` dynamic variable.

```tf
# main.tf
resource "grafana_data_source" "prometheus" {
}

module "alert" {
  source  = "timtorChen/grafana-rule-groups/module"
  version = "0.1.0"

  folder_name        = "node"
  datasource_uid     = grafana_data_source.prometheus.uid
  static_rule_groups = yamldecode(templatefile("${path.module}/node-exporter-rules.yaml", {}))
  rule_groups        = {}
}
```

```yaml
# node-exporter-rules.yaml
---
# yaml-language-server: $schema=https://raw.githubusercontent.com/timtorChen/terraform-module-grafana-rule-groups/refs/heads/main/schema.json
- name: metrics-check
  interval_seconds: 300
  rules:
    - name: node-no-data
      annotations:
        summary: "Node-exporter metrics return NoData"
        description: >-
          Node-exporter metrics has been no data for 5 minutes.
          Please check if node-exporter or Prometheus is working.
      condition: "Z"
      datas:
        - ref_id: "Z"
          model:
            expr: "absent(node_uname_info) or vector(0)"
            instant: true
      no_data_state: "Alerting"
      exec_err_state: "Error"
      for: "5m"
      labels:
        severity: "critical"
```

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                               | Version |
| ------------------------------------------------------------------ | ------- |
| <a name="requirement_grafana"></a> [grafana](#requirement_grafana) | 3.7.0   |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_grafana"></a> [grafana](#provider_grafana) | 3.7.0   |

## Modules

No modules.

## Resources

| Name                                                                                                               | Type     |
| ------------------------------------------------------------------------------------------------------------------ | -------- |
| [grafana_folder.this](https://registry.terraform.io/providers/grafana/grafana/3.7.0/docs/resources/folder)         | resource |
| [grafana_rule_group.this](https://registry.terraform.io/providers/grafana/grafana/3.7.0/docs/resources/rule_group) | resource |

## Inputs

| Name                                                                                    | Description | Type          | Default | Required |
| --------------------------------------------------------------------------------------- | ----------- | ------------- | ------- | :------: |
| <a name="input_folder_name"></a> [folder_name](#input_folder_name)                      | n/a         | `string`      | n/a     |   yes    |
| <a name="input_labels"></a> [labels](#input_labels)                                     | n/a         | `map(string)` | `{}`    |    no    |
| <a name="input_annotations"></a> [annotations](#input_annotations)                      | n/a         | `map(string)` | `{}`    |    no    |
| <a name="input_datasource_uid"></a> [datasource_uid](#input_datasource_uid)             | n/a         | `string`      | `""`    |    no    |
| <a name="input_static_rule_groups"></a> [static_rule_groups](#input_static_rule_groups) | n/a         | `any`         | n/a     |   yes    |
| <a name="input_rule_groups"></a> [rule_groups](#input_rule_groups)                      | n/a         | `any`         | n/a     |   yes    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
