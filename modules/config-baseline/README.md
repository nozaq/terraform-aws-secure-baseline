# config-baseline

Enable AWS Config in all regions to automatically take configuration snapshots.

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
| [aws_config_configuration_recorder](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/config_configuration_recorder) |
| [aws_config_configuration_recorder_status](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/config_configuration_recorder_status) |
| [aws_config_delivery_channel](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/config_delivery_channel) |
| [aws_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/sns_topic) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| delivery\_channel\_name | The name of the delivery channel. | `string` | `"default"` | no |
| delivery\_frequency | The frequency which AWS Config sends a snapshot into the S3 bucket. | `string` | `"One_Hour"` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| iam\_role\_arn | The ARN of the IAM Role which AWS Config will use. | `any` | n/a | yes |
| include\_global\_resource\_types | Specifies whether AWS Config includes all supported types of global resources with the resources that it records. | `bool` | `true` | no |
| recorder\_name | The name of the configuration recorder. | `string` | `"default"` | no |
| s3\_bucket\_name | The name of the S3 bucket which will store configuration snapshots. | `any` | n/a | yes |
| s3\_key\_prefix | The prefix for the specified S3 bucket. | `string` | `""` | no |
| sns\_topic\_name | The name of the SNS Topic to be used to notify configuration changes. | `string` | `"ConfigChanges"` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| config\_sns\_topic | The SNS topic that AWS Config delivers notifications to. |
| configuration\_recorder | The configuration recorder. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
