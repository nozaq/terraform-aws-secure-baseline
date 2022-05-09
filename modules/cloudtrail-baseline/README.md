# cloudtrail-baseline

Enable CloudTrail in all regions and deliver events to CloudWatch Logs. CloudTrail logs are encrypted using AWS Key Management Service.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.3 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID number of the account. | `string` | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region in which CloudTrail is set up. | `string` | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | The name of the S3 bucket which will store configuration snapshots. | `string` | yes |
| <a name="input_cloudtrail_depends_on"></a> [cloudtrail\_depends\_on](#input\_cloudtrail\_depends\_on) | External resources which should be set up before CloudTrail. | `list(any)` | no |
| <a name="input_cloudtrail_name"></a> [cloudtrail\_name](#input\_cloudtrail\_name) | The name of the trail. | `string` | no |
| <a name="input_cloudtrail_sns_topic_enabled"></a> [cloudtrail\_sns\_topic\_enabled](#input\_cloudtrail\_sns\_topic\_enabled) | Specifies whether the trail is delivered to a SNS topic. | `bool` | no |
| <a name="input_cloudtrail_sns_topic_name"></a> [cloudtrail\_sns\_topic\_name](#input\_cloudtrail\_sns\_topic\_name) | The SNS topic linked to the CloudTrail | `string` | no |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch\_logs\_enabled](#input\_cloudwatch\_logs\_enabled) | Specifies whether the trail is delivered to CloudWatch Logs. | `bool` | no |
| <a name="input_cloudwatch_logs_group_name"></a> [cloudwatch\_logs\_group\_name](#input\_cloudwatch\_logs\_group\_name) | The name of CloudWatch Logs group to which CloudTrail events are delivered. | `string` | no |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | no |
| <a name="input_dynamodb_event_logging_tables"></a> [dynamodb\_event\_logging\_tables](#input\_dynamodb\_event\_logging\_tables) | The list of DynamoDB table ARNs on which to enable event logging. | `list(string)` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | no |
| <a name="input_iam_role_policy_name"></a> [iam\_role\_policy\_name](#input\_iam\_role\_policy\_name) | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | no |
| <a name="input_is_organization_trail"></a> [is\_organization\_trail](#input\_is\_organization\_trail) | Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. | `bool` | no |
| <a name="input_key_deletion_window_in_days"></a> [key\_deletion\_window\_in\_days](#input\_key\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. | `number` | no |
| <a name="input_lambda_invocation_logging_lambdas"></a> [lambda\_invocation\_logging\_lambdas](#input\_lambda\_invocation\_logging\_lambdas) | The list of lambda ARNs on which to enable invocation logging. | `list(string)` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | The permissions boundary ARN for all IAM Roles, provisioned by this module | `string` | no |
| <a name="input_s3_key_prefix"></a> [s3\_key\_prefix](#input\_s3\_key\_prefix) | The prefix for the specified S3 bucket. | `string` | no |
| <a name="input_s3_object_level_logging_buckets"></a> [s3\_object\_level\_logging\_buckets](#input\_s3\_object\_level\_logging\_buckets) | The list of S3 bucket ARNs on which to enable object-level logging. | `list(string)` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudtrail"></a> [cloudtrail](#output\_cloudtrail) | The trail for recording events in all regions. |
| <a name="output_cloudtrail_sns_topic"></a> [cloudtrail\_sns\_topic](#output\_cloudtrail\_sns\_topic) | The sns topic linked to the cloudtrail. |
| <a name="output_kms_key"></a> [kms\_key](#output\_kms\_key) | The  KMS key used for encrypting CloudTrail events. |
| <a name="output_log_delivery_iam_role"></a> [log\_delivery\_iam\_role](#output\_log\_delivery\_iam\_role) | The IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| <a name="output_log_group"></a> [log\_group](#output\_log\_group) | The CloudWatch Logs log group which stores CloudTrail events. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
