# vpc-baseline

## Features

- Enable VPC Flow Logs with the default VPC in all regions.
- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_flow\_logs | The boolean flag whether to enable VPC Flow Logs in the default VPC | `bool` | `true` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| flow\_logs\_destination\_type | The type of the logging destination. Valid values: cloud-watch-logs, s3 | `string` | `"cloud-watch-logs"` | no |
| flow\_logs\_iam\_role\_arn | The ARN of the IAM Role which will be used by VPC Flow Logs if vpc\_log\_destination\_type is cloud-watch-logs. | `string` | `""` | no |
| flow\_logs\_log\_group\_name | The name of CloudWatch Logs group to which VPC Flow Logs are delivered if vpc\_log\_destination\_type is cloud-watch-logs. | `string` | `""` | no |
| flow\_logs\_retention\_in\_days | Number of days to retain logs if vpc\_log\_destination\_type is cloud-watch-logs. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| flow\_logs\_s3\_arn | The ARN of the S3 bucket to which VPC Flow Logs are delivered if vpc\_log\_destination\_type is s3. | `string` | `""` | no |
| flow\_logs\_s3\_key\_prefix | The prefix used when VPC Flow Logs delivers logs to the S3 bucket. | `string` | `"flow-logs"` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| default\_network\_acl | The default network ACL. |
| default\_route\_table | The default route table. |
| default\_security\_group | The default security group. |
| default\_vpc | The default VPC. |
| vpc\_flow\_logs\_group | The CloudWatch Logs log group which stores VPC Flow Logs. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
