# alarm-baseline

Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.

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
| <a name="input_cloudtrail_log_group_name"></a> [cloudtrail\_log\_group\_name](#input\_cloudtrail\_log\_group\_name) | The name of the CloudWatch Logs group to which CloudTrail events are delivered. | `string` | yes |
| <a name="input_alarm_namespace"></a> [alarm\_namespace](#input\_alarm\_namespace) | The namespace in which all alarms are set up. | `string` | no |
| <a name="input_aws_config_changes_enabled"></a> [aws\_config\_changes\_enabled](#input\_aws\_config\_changes\_enabled) | The boolean flag whether the aws\_config\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_cloudtrail_cfg_changes_enabled"></a> [cloudtrail\_cfg\_changes\_enabled](#input\_cloudtrail\_cfg\_changes\_enabled) | The boolean flag whether the cloudtrail\_cfg\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_console_signin_failures_enabled"></a> [console\_signin\_failures\_enabled](#input\_console\_signin\_failures\_enabled) | The boolean flag whether the console\_signin\_failures alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_disable_or_delete_cmk_enabled"></a> [disable\_or\_delete\_cmk\_enabled](#input\_disable\_or\_delete\_cmk\_enabled) | The boolean flag whether the disable\_or\_delete\_cmk alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_iam_changes_enabled"></a> [iam\_changes\_enabled](#input\_iam\_changes\_enabled) | The boolean flag whether the iam\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_mfa_console_signin_allow_sso"></a> [mfa\_console\_signin\_allow\_sso](#input\_mfa\_console\_signin\_allow\_sso) | The boolean flag whether the no\_mfa\_console\_signin alarm allows SSO auth to be ignored. | `bool` | no |
| <a name="input_nacl_changes_enabled"></a> [nacl\_changes\_enabled](#input\_nacl\_changes\_enabled) | The boolean flag whether the nacl\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_network_gw_changes_enabled"></a> [network\_gw\_changes\_enabled](#input\_network\_gw\_changes\_enabled) | The boolean flag whether the network\_gw\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_no_mfa_console_signin_enabled"></a> [no\_mfa\_console\_signin\_enabled](#input\_no\_mfa\_console\_signin\_enabled) | The boolean flag whether the no\_mfa\_console\_signin alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_organizations_changes_enabled"></a> [organizations\_changes\_enabled](#input\_organizations\_changes\_enabled) | The boolean flag whether the organizations\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_root_usage_enabled"></a> [root\_usage\_enabled](#input\_root\_usage\_enabled) | The boolean flag whether the root\_usage alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_route_table_changes_enabled"></a> [route\_table\_changes\_enabled](#input\_route\_table\_changes\_enabled) | The boolean flag whether the route\_table\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_s3_bucket_policy_changes_enabled"></a> [s3\_bucket\_policy\_changes\_enabled](#input\_s3\_bucket\_policy\_changes\_enabled) | The boolean flag whether the s3\_bucket\_policy\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_security_group_changes_enabled"></a> [security\_group\_changes\_enabled](#input\_security\_group\_changes\_enabled) | The boolean flag whether the security\_group\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_sns_topic_kms_master_key_id"></a> [sns\_topic\_kms\_master\_key\_id](#input\_sns\_topic\_kms\_master\_key\_id) | To enable SNS Topic encryption enter value with the ID of a custom master KMS key that is used for encryption | `string` | no |
| <a name="input_sns_topic_name"></a> [sns\_topic\_name](#input\_sns\_topic\_name) | The name of the SNS Topic which will be notified when any alarm is performed. | `string` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | no |
| <a name="input_unauthorized_api_calls_enabled"></a> [unauthorized\_api\_calls\_enabled](#input\_unauthorized\_api\_calls\_enabled) | The boolean flag whether the unauthorized\_api\_calls alarm is enabled or not. No resources are created when set to false. | `bool` | no |
| <a name="input_vpc_changes_enabled"></a> [vpc\_changes\_enabled](#input\_vpc\_changes\_enabled) | The boolean flag whether the vpc\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alarm_sns_topic"></a> [alarm\_sns\_topic](#output\_alarm\_sns\_topic) | The SNS topic to which CloudWatch Alarms will be sent. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
