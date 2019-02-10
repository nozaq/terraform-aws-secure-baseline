# vpc-baseline

## Features

- Enable VPC Flow Logs with the default VPC in all regions.
- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc\_flow\_logs\_iam\_role\_arn | The ARN of the IAM Role which will be used by VPC Flow Logs. | string | n/a | yes |
| vpc\_log\_group\_name | The name of CloudWatch Logs group to which VPC Flow Logs are delivered. | string | n/a | yes |
| vpc\_log\_retention\_in\_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| default\_network\_acl\_id | The ID of the default network ACL. |
| default\_route\_table\_id | The ID of the default route table. |
| default\_security\_group\_id | The ID of the default security group. |
| default\_vpc\_id | The ID of the default VPC. |
| vpc\_flow\_logs\_group\_arn | The ARN of the CloudWatch Logs log group which stores VPC Flow Logs. |
| vpc\_flow\_logs\_group\_name | The name of the CloudWatch Logs log group which stores VPC Flow Logs. |
