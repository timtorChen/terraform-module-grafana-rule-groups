# Terraform grafana rule groups module

⚠️ This project is still under development; use it with caution.

The helper module to create grafana alerts.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | 3.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 3.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [grafana_folder.this](https://registry.terraform.io/providers/grafana/grafana/3.7.0/docs/resources/folder) | resource |
| [grafana_rule_group.this](https://registry.terraform.io/providers/grafana/grafana/3.7.0/docs/resources/rule_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder_name"></a> [folder\_name](#input\_folder\_name) | n/a | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_annotations"></a> [annotations](#input\_annotations) | n/a | `map(string)` | `{}` | no |
| <a name="input_datasource_uid"></a> [datasource\_uid](#input\_datasource\_uid) | n/a | `string` | `""` | no |
| <a name="input_static_rule_groups"></a> [static\_rule\_groups](#input\_static\_rule\_groups) | n/a | `any` | n/a | yes |
| <a name="input_rule_groups"></a> [rule\_groups](#input\_rule\_groups) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->