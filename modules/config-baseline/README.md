# config-baseline

Enable AWS Config in all regions to automatically take configuration snapshots.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| delivery_channel_name | The name of the delivery channel. | string | `default` | no |
| delivery_frequency | The frequency which AWS Config sends a snapshot into the S3 bucket. | string | `One_Hour` | no |
| iam_role_arn | The ARN of the IAM Role which AWS Config will use. | string | - | yes |
| recorder_name | The name of the configuration recorder. | string | `default` | no |
| s3_bucket_name | The name of the S3 bucket which will store configuration snapshots. | string | - | yes |
| s3_key_prefix | The prefix for the specified S3 bucket. | string | `` | no |
| sns_topic_name | The name of the SNS Topic to be used to notify configuration changes. | string | `ConfigChanges` | no |

## Outputs

| Name | Description |
|------|-------------|
| config_topic_arn | The ARN of the SNS topic that AWS Config delivers notifications to. |
| configuration_recorder_id | The name of the configuration recorder. |
