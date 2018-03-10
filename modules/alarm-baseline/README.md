# alarm-baseline

Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm_namespace | The namespace in which all alarms are set up. | string | `CISBenchmark` | no |
| cloudtrail_log_group_name | The name of the CloudWatch Logs group to which CloudTrail events are delivered. | string | - | yes |
| sns_topic_name | The name of the SNS Topic which will be notified when any alarm is performed. | string | `CISAlarm` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarm_topic_arn | The ARN of the SNS topic to which CloudWatch Alarms will be sent. |
