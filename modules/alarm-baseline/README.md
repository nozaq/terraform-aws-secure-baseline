# alarm-baseline

Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm\_namespace | The namespace in which all alarms are set up. | string | `"CISBenchmark"` | no |
| cloudtrail\_log\_group\_name | The name of the CloudWatch Logs group to which CloudTrail events are delivered. | string | n/a | yes |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | string | `"true"` | no |
| sns\_topic\_name | The name of the SNS Topic which will be notified when any alarm is performed. | string | `"CISAlarm"` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarm\_sns\_topic | The SNS topic to which CloudWatch Alarms will be sent. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
