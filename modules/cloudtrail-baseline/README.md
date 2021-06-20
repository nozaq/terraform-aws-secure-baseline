# cloudtrail-baseline

Enable CloudTrail in all regions and deliver events to CloudWatch Logs. CloudTrail logs are encrypted using AWS Key Management Service.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13   |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.50.0 |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 3.60.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                            | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_cloudtrail.global](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail)                                                 | resource    |
| [aws_cloudwatch_log_group.cloudtrail_events](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)                  | resource    |
| [aws_iam_role.cloudwatch_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)                                        | resource    |
| [aws_iam_role_policy.cloudwatch_delivery_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy)                   | resource    |
| [aws_kms_key.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key)                                                   | resource    |
| [aws_sns_topic.cloudtrail-sns-topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic)                                     | resource    |
| [aws_sns_topic_policy.local-account-cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy)                   | resource    |
| [aws_iam_policy_document.cloudtrail-sns-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)             | data source |
| [aws_iam_policy_document.cloudtrail_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)             | data source |
| [aws_iam_policy_document.cloudwatch_delivery_assume_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cloudwatch_delivery_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document)        | data source |

## Inputs

| Name                                                                                                                                 | Description                                                                                                                                                                                            | Type     | Default                                   | Required |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------- | ----------------------------------------- | :------: |
| <a name="input_aws_account_id"></a> [aws_account_id](#input_aws_account_id)                                                          | The AWS Account ID number of the account.                                                                                                                                                              | `any`    | n/a                                       |   yes    |
| <a name="input_cloudtrail_depends_on"></a> [cloudtrail_depends_on](#input_cloudtrail_depends_on)                                     | External resources which should be set up before CloudTrail.                                                                                                                                           | `list`   | `[]`                                      |    no    |
| <a name="input_cloudtrail_name"></a> [cloudtrail_name](#input_cloudtrail_name)                                                       | The name of the trail.                                                                                                                                                                                 | `string` | `"cloudtrail-multi-region"`               |    no    |
| <a name="input_cloudtrail_sns_topic_enabled"></a> [cloudtrail_sns_topic_enabled](#input_cloudtrail_sns_topic_enabled)                | Specifies whether the trail is delivered to a SNS topic.                                                                                                                                               | `bool`   | `true`                                    |    no    |
| <a name="input_cloudtrail_sns_topic_name"></a> [cloudtrail_sns_topic_name](#input_cloudtrail_sns_topic_name)                         | The SNS topic linked to the CloudTrail                                                                                                                                                                 | `string` | `"cloudtrail-multi-region-sns-topic"`     |    no    |
| <a name="input_cloudwatch_logs_enabled"></a> [cloudwatch_logs_enabled](#input_cloudwatch_logs_enabled)                               | Specifies whether the trail is delivered to CloudWatch Logs.                                                                                                                                           | `bool`   | `true`                                    |    no    |
| <a name="input_cloudwatch_logs_group_name"></a> [cloudwatch_logs_group_name](#input_cloudwatch_logs_group_name)                      | The name of CloudWatch Logs group to which CloudTrail events are delivered.                                                                                                                            | `string` | `"cloudtrail-multi-region"`               |    no    |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch_logs_retention_in_days](#input_cloudwatch_logs_retention_in_days) | Number of days to retain logs for. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365`                                     |    no    |
| <a name="input_dynamodb_event_logging_tables"></a> [dynamodb_event_logging_tables](#input_dynamodb_event_logging_tables)             | The list of DynamoDB table ARNs on which to enable event logging.                                                                                                                                      | `list`   | <pre>[<br> "arn:aws:dynamodb"<br>]</pre>  |    no    |
| <a name="input_enabled"></a> [enabled](#input_enabled)                                                                               | The boolean flag whether this module is enabled or not. No resources are created when set to false.                                                                                                    | `bool`   | `true`                                    |    no    |
| <a name="input_iam_role_name"></a> [iam_role_name](#input_iam_role_name)                                                             | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group.                                                                                                           | `string` | `"CloudTrail-CloudWatch-Delivery-Role"`   |    no    |
| <a name="input_iam_role_policy_name"></a> [iam_role_policy_name](#input_iam_role_policy_name)                                        | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group.                                                                                                    | `string` | `"CloudTrail-CloudWatch-Delivery-Policy"` |    no    |
| <a name="input_is_organization_trail"></a> [is_organization_trail](#input_is_organization_trail)                                     | Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account.      | `bool`   | `false`                                   |    no    |
| <a name="input_key_deletion_window_in_days"></a> [key_deletion_window_in_days](#input_key_deletion_window_in_days)                   | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days.                                                                 | `number` | `10`                                      |    no    |
| <a name="input_lambda_invocation_logging_lambdas"></a> [lambda_invocation_logging_lambdas](#input_lambda_invocation_logging_lambdas) | The list of lambda ARNs on which to enable invocation logging.                                                                                                                                         | `list`   | <pre>[<br> "arn:aws:lambda"<br>]</pre>    |    no    |
| <a name="input_region"></a> [region](#input_region)                                                                                  | The AWS region in which CloudTrail is set up.                                                                                                                                                          | `any`    | n/a                                       |   yes    |
| <a name="input_s3_bucket_name"></a> [s3_bucket_name](#input_s3_bucket_name)                                                          | The name of the S3 bucket which will store configuration snapshots.                                                                                                                                    | `any`    | n/a                                       |   yes    |
| <a name="input_s3_key_prefix"></a> [s3_key_prefix](#input_s3_key_prefix)                                                             | The prefix for the specified S3 bucket.                                                                                                                                                                | `string` | `""`                                      |    no    |
| <a name="input_s3_object_level_logging_buckets"></a> [s3_object_level_logging_buckets](#input_s3_object_level_logging_buckets)       | The list of S3 bucket ARNs on which to enable object-level logging.                                                                                                                                    | `list`   | <pre>[<br> "arn:aws:s3:::"<br>]</pre>     |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                        | Specifies object tags key and value. This applies to all resources created by this module.                                                                                                             | `map`    | <pre>{<br> "Terraform": true<br>}</pre>   |    no    |

## Outputs

| Name                                                                                               | Description                                                            |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| <a name="output_cloudtrail"></a> [cloudtrail](#output_cloudtrail)                                  | The trail for recording events in all regions.                         |
| <a name="output_cloudtrail_sns_topic"></a> [cloudtrail_sns_topic](#output_cloudtrail_sns_topic)    | The sns topic linked to the cloudtrail.                                |
| <a name="output_kms_key"></a> [kms_key](#output_kms_key)                                           | The KMS key used for encrypting CloudTrail events.                     |
| <a name="output_log_delivery_iam_role"></a> [log_delivery_iam_role](#output_log_delivery_iam_role) | The IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| <a name="output_log_group"></a> [log_group](#output_log_group)                                     | The CloudWatch Logs log group which stores CloudTrail events.          |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
