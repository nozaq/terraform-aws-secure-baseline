# terraform-aws-secure-baseline

[![CircleCI](https://circleci.com/gh/nozaq/terraform-aws-secure-baseline.svg?style=svg)](https://circleci.com/gh/nozaq/terraform-aws-secure-baseline)

[Terraform Module Registry](https://registry.terraform.io/modules/nozaq/secure-baseline/aws)

A terraform module to set up your AWS account with the reasonably secure configuration baseline.
Most configurations are based on [CIS Amazon Web Services Foundations] v1.2.0.

See [Benchmark Compliance](./compliance.md) to check which items in CIS benchmark are covered.

## Features

### Identity and Access Management

- Set up IAM Password Policy.
- Creates separated IAM roles for defining privileges and assigning them to entities such as IAM users and groups.
- Creates an IAM role for contacting AWS support for incident handling.
- Enable AWS Config rules to audit root account status.

### Logging & Monitoring

- Enable CloudTrail in all regions and deliver events to CloudWatch Logs.
- CloudTrail logs are encrypted using AWS Key Management Service.
- All logs are stored in the S3 bucket with access logging enabled.
- Logs are automatically archived into Amazon Glacier after the given period(defaults to 90 days).
- Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.
- Enable AWS Config in all regions to automatically take configuration snapshots.

### Networking

- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.
- Enable AWS Config rules to audit unrestricted common ports in Security Group rules.
- Enable VPC Flow Logs with the default VPC in all regions.
- Enable GuardDuty in all regions.

## Usage

```hcl
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "secure-baseline" {
  source  = "nozaq/secure-baseline/aws"

  audit_log_bucket_name = "YOUR_BUCKET_NAME"
  aws_account_id = "${data.aws_caller_identity.current.account_id}"
  region = "${data.aws_region.current.name}"
  support_iam_role_principal_arn = "YOUR_IAM_USER"

  providers = {
    "aws"                = "aws"
    "aws.ap-northeast-1" = "aws.ap-northeast-1"
    "aws.ap-northeast-2" = "aws.ap-northeast-2"
    "aws.ap-south-1"     = "aws.ap-south-1"
    "aws.ap-southeast-1" = "aws.ap-southeast-1"
    "aws.ap-southeast-2" = "aws.ap-southeast-2"
    "aws.ap-southeast-2" = "aws.ap-southeast-2"
    "aws.ca-central-1"   = "aws.ca-central-1"
    "aws.eu-central-1"   = "aws.eu-central-1"
    "aws.eu-west-1"      = "aws.eu-west-1"
    "aws.eu-west-2"      = "aws.eu-west-2"
    "aws.eu-west-3"      = "aws.eu-west-3"
    "aws.sa-east-1"      = "aws.sa-east-1"
    "aws.us-east-1"      = "aws.us-east-1"
    "aws.us-east-2"      = "aws.us-east-2"
    "aws.us-west-1"      = "aws.us-west-1"
    "aws.us-west-2"      = "aws.us-west-2"
  }
}
```

Check [the example](./examples/root-example/regions.tf) to understand how these providers are defined.
Note that you need to define a provider for each AWS region and pass them to the module. Currently this is the recommended way to handle multiple regions in one module.
Detailed information can be found at [Providers within Modules - Terraform Docs].

## Submodules

This module is composed of several submodules and each of which can be used independently.

- [alarm-baseline](./modules/alarm-baseline)
- [cloudtrail-baseline](./modules/cloudtrail-baseline)
- [guardduty-baseline](./modules/guardduty-baseline)
- [iam-baseline](./modules/iam-baseline)
- [vpc-baseline](./modules/vpc-baseline)
- [secure-bucket](./modules/secure-bucket)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm_namespace | The namespace in which all alarms are set up. | string | `CISBenchmark` | no |
| alarm_sns_topic_name | The name of the SNS Topic which will be notified when any alarm is performed. | string | `CISAlarm` | no |
| allow_users_to_change_password | Whether to allow users to change their own password. | string | `true` | no |
| audit_log_bucket_name | The name of the S3 bucket to store various audit logs. | string | - | yes |
| audit_log_lifecycle_glacier_transition_days | The number of days after log creation when the log file is archived into Glacier. | string | `90` | no |
| aws_account_id | The AWS Account ID number of the account. | string | - | yes |
| cloudtrail_cloudwatch_logs_group_name | The name of CloudWatch Logs group to which CloudTrail events are delivered. | string | `cloudtrail-multi-region` | no |
| cloudtrail_iam_role_name | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | string | `CloudTrail-CloudWatch-Delivery-Role` | no |
| cloudtrail_iam_role_policy_name | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | string | `CloudTrail-CloudWatch-Delivery-Policy` | no |
| cloudtrail_key_deletion_window_in_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. | string | `10` | no |
| cloudtrail_name | The name of the trail. | string | `cloudtrail-multi-region` | no |
| cloudtrail_s3_key_prefix | The prefix used when CloudTrail delivers events to the S3 bucket. | string | `cloudtrail` | no |
| cloudwatch_logs_retention_in_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | string | `365` | no |
| config_delivery_frequency | The frequency which AWS Config sends a snapshot into the S3 bucket. | string | `One_Hour` | no |
| config_iam_role_name | The name of the IAM Role which AWS Config will use. | string | `Config-Recorder` | no |
| config_iam_role_policy_name | The name of the IAM Role Policy which AWS Config will use. | string | `Config-Recorder-Policy` | no |
| config_s3_bucket_key_prefix | The prefix used when writing AWS Config snapshots into the S3 bucket. | string | `config` | no |
| config_sns_topic_name | The name of the SNS Topic to be used to notify configuration changes. | string | `ConfigChanges` | no |
| manager_iam_role_name | The name of the IAM Manager role. | string | `IAM-Manager` | no |
| manager_iam_role_policy_name | The name of the IAM Manager role policy. | string | `IAM-Manager-Policy` | no |
| master_iam_role_name | The name of the IAM Master role. | string | `IAM-Master` | no |
| master_iam_role_policy_name | The name of the IAM Master role policy. | string | `IAM-Master-Policy` | no |
| max_password_age | The number of days that an user password is valid. | string | `90` | no |
| minimum_password_length | Minimum length to require for user passwords. | string | `14` | no |
| password_reuse_prevention | The number of previous passwords that users are prevented from reusing. | string | `24` | no |
| region | The AWS region in which global resources are set up. | string | - | yes |
| require_lowercase_characters | Whether to require lowercase characters for user passwords. | string | `true` | no |
| require_numbers | Whether to require numbers for user passwords. | string | `true` | no |
| require_symbols | Whether to require symbols for user passwords. | string | `true` | no |
| require_uppercase_characters | Whether to require uppercase characters for user passwords. | string | `true` | no |
| support_iam_role_name | The name of the the support role. | string | `IAM-Support` | no |
| support_iam_role_policy_name | The name of the support role policy. | string | `IAM-Support-Role` | no |
| support_iam_role_principal_arn | The ARN of the IAM principal element by which the support role could be assumed. | string | - | yes |
| vpc_iam_role_name | The name of the IAM Role which VPC Flow Logs will use. | string | `VPC-Flow-Logs-Publisher` | no |
| vpc_iam_role_policy_name | The name of the IAM Role Policy which VPC Flow Logs will use. | string | `VPC-Flow-Logs-Publish-Policy` | no |
| vpc_log_group_name | The name of CloudWatch Logs group to which VPC Flow Logs are delivered. | string | `default-vpc-flow-logs` | no |
| vpc_log_retention_in_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | string | `365` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarms_topic_arn | The ARN of the SNS topic to which CloudWatch Alarms will be sent. |
| audit_bucket_arn | The ARN of the S3 bucket used for storing audit logs. |
| audit_bucket_id | The ID of the S3 bucket used for storing audit logs. |
| cloudtrail_arn | The ARN of the trail for recording events in all regions. |
| cloudtrail_id | The ID of the trail for recording events in all regions. |
| cloudtrail_kms_key_arn | The ARN of the KMS key used for encrypting CloudTrail events. |
| cloudtrail_kms_key_id | The ID of the KMS key used for encrypting CloudTrail events. |
| cloudtrail_log_delivery_iam_role_arn | The ARN of the IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| cloudtrail_log_delivery_iam_role_name | The name of the IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| cloudtrail_log_group_arn | The ARN of the CloudWatch Logs log group which stores CloudTrail events. |
| cloudtrail_log_group_name | The name of the CloudWatch Logs log group which stores CloudTrail events. |
| config_configuration_recorder_id | The name of the configuration recorder. |
| config_iam_role_arn | The ARN of the IAM role used for delivering AWS Config records to CloudWatch Logs. |
| config_iam_role_name | The name of the IAM role used for delivering AWS Config records to CloudWatch Logs. |
| config_topic_arn | The ARN of the SNS topic that AWS Config delivers notifications to. |
| default_network_acl_id | The ID of the default network ACL. |
| default_route_table_id | The ID of the default route table. |
| default_security_group_id | The ID of the default security group. |
| default_vpc_id | The ID of the default VPC. |
| guardduty_detector_id | The ID of the GuardDuty detector. |
| manager_iam_role_arn | The ARN of the IAM role used for the manager user. |
| manager_iam_role_name | The name of the IAM role used for the manager user. |
| master_iam_role_arn | The ARN of the IAM role used for the master user. |
| master_iam_role_name | The name of the IAM role used for the master user. |
| support_iam_role_arn | The ARN of the IAM role used for the support user. |
| support_iam_role_name | The name of the IAM role used for the support user. |
| vpc_flow_logs_group_arn | The ARN of the CloudWatch Logs log group which stores VPC Flow Logs. |
| vpc_flow_logs_group_name | The name of the CloudWatch Logs log group which stores VPC Flow Logs. |
| vpc_flow_logs_iam_role_arn | The ARN of the IAM role used for delivering VPC Flow Logs to CloudWatch Logs. |
| vpc_flow_logs_iam_role_name | The name of the IAM role used for delivering VPC Flow Logs to CloudWatch Logs. |

[CIS Amazon Web Services Foundations]: https://www.cisecurity.org/benchmark/amazon_web_services/
[Providers within Modules - Terraform Docs]: https://www.terraform.io/docs/modules/usage.html#providers-within-modules
