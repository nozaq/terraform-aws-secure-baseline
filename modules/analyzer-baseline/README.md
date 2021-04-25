# analyzer-baseline

## Features

- Enable IAM Acess Analyzer

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_accessanalyzer_analyzer](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/accessanalyzer_analyzer) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| analyzer\_name | The name for the IAM Access Analyzer resource to be created. | `string` | `"default-analyer"` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| is\_organization | The boolean flag whether this module is configured for the organization master account or the individual account. | `bool` | `false` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
