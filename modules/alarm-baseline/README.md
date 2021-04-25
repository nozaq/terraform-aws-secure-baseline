# alarm-baseline

Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.

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
| [aws_cloudwatch_log_metric_filter](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/cloudwatch_log_metric_filter) |
| [aws_cloudwatch_metric_alarm](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/cloudwatch_metric_alarm) |
| [aws_sns_topic](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/sns_topic) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_namespace | The namespace in which all alarms are set up. | `string` | `"CISBenchmark"` | no |
| aws\_config\_changes\_enabled | The boolean flag whether the aws\_config\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| cloudtrail\_cfg\_changes\_enabled | The boolean flag whether the cloudtrail\_cfg\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| cloudtrail\_log\_group\_name | The name of the CloudWatch Logs group to which CloudTrail events are delivered. | `any` | n/a | yes |
| console\_signin\_failures\_enabled | The boolean flag whether the console\_signin\_failures alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| disable\_or\_delete\_cmk\_enabled | The boolean flag whether the disable\_or\_delete\_cmk alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| iam\_changes\_enabled | The boolean flag whether the iam\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| nacl\_changes\_enabled | The boolean flag whether the nacl\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| network\_gw\_changes\_enabled | The boolean flag whether the network\_gw\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| no\_mfa\_console\_signin\_enabled | The boolean flag whether the no\_mfa\_console\_signin alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| organizations\_changes\_enabled | The boolean flag whether the organizations\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| root\_usage\_enabled | The boolean flag whether the root\_usage alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| route\_table\_changes\_enabled | The boolean flag whether the route\_table\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| s3\_bucket\_policy\_changes\_enabled | The boolean flag whether the s3\_bucket\_policy\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| security\_group\_changes\_enabled | The boolean flag whether the security\_group\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| sns\_topic\_name | The name of the SNS Topic which will be notified when any alarm is performed. | `string` | `"CISAlarm"` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |
| unauthorized\_api\_calls\_enabled | The boolean flag whether the unauthorized\_api\_calls alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| vpc\_changes\_enabled | The boolean flag whether the vpc\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarm\_sns\_topic | The SNS topic to which CloudWatch Alarms will be sent. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
