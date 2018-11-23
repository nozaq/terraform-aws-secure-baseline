# vpc-baseline

## Features

- Enable VPC Flow Logs with the default VPC in all regions.
- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc_flow_logs_group_name | The name of the CloudWatch Logs group to which VPC Flow Logs will be written. | string | - | yes |
| vpc_flow_logs_iam_role_arn | The ARN of the IAM Role which will be used by VPC Flow Logs. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| default_network_acl_id | The ID of the default network ACL. |
| default_route_table_id | The ID of the default route table. |
| default_security_group_id | The ID of the default security group. |
| default_vpc_id | The ID of the default VPC. |
