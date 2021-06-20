# vpc-baseline

## Features

- Enable VPC Flow Logs with the default VPC in all regions.
- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.
- Disable automatic public IP assignments in default subnets.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.default_vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_default_network_acl.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_network_acl) | resource |
| [aws_default_route_table.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_route_table) | resource |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_default_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_subnet) | resource |
| [aws_default_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_vpc) | resource |
| [aws_flow_log.default_vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_availability_zones.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_flow_logs"></a> [enable\_flow\_logs](#input\_enable\_flow\_logs) | The boolean flag whether to enable VPC Flow Logs in the default VPC | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_flow_logs_destination_type"></a> [flow\_logs\_destination\_type](#input\_flow\_logs\_destination\_type) | The type of the logging destination. Valid values: cloud-watch-logs, s3 | `string` | `"cloud-watch-logs"` | no |
| <a name="input_flow_logs_iam_role_arn"></a> [flow\_logs\_iam\_role\_arn](#input\_flow\_logs\_iam\_role\_arn) | The ARN of the IAM Role which will be used by VPC Flow Logs if vpc\_log\_destination\_type is cloud-watch-logs. | `string` | `""` | no |
| <a name="input_flow_logs_log_group_name"></a> [flow\_logs\_log\_group\_name](#input\_flow\_logs\_log\_group\_name) | The name of CloudWatch Logs group to which VPC Flow Logs are delivered if vpc\_log\_destination\_type is cloud-watch-logs. | `string` | `""` | no |
| <a name="input_flow_logs_retention_in_days"></a> [flow\_logs\_retention\_in\_days](#input\_flow\_logs\_retention\_in\_days) | Number of days to retain logs if vpc\_log\_destination\_type is cloud-watch-logs. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| <a name="input_flow_logs_s3_arn"></a> [flow\_logs\_s3\_arn](#input\_flow\_logs\_s3\_arn) | The ARN of the S3 bucket to which VPC Flow Logs are delivered if vpc\_log\_destination\_type is s3. | `string` | `""` | no |
| <a name="input_flow_logs_s3_key_prefix"></a> [flow\_logs\_s3\_key\_prefix](#input\_flow\_logs\_s3\_key\_prefix) | The prefix used when VPC Flow Logs delivers logs to the S3 bucket. | `string` | `"flow-logs"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_network_acl"></a> [default\_network\_acl](#output\_default\_network\_acl) | The default network ACL. |
| <a name="output_default_route_table"></a> [default\_route\_table](#output\_default\_route\_table) | The default route table. |
| <a name="output_default_security_group"></a> [default\_security\_group](#output\_default\_security\_group) | The default security group. |
| <a name="output_default_vpc"></a> [default\_vpc](#output\_default\_vpc) | The default VPC. |
| <a name="output_vpc_flow_logs_group"></a> [vpc\_flow\_logs\_group](#output\_vpc\_flow\_logs\_group) | The CloudWatch Logs log group which stores VPC Flow Logs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
