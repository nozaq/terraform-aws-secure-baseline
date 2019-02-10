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
[Modules in Package Sub-directories - Terraform] describes how to source a submodule.

- [alarm-baseline](./modules/alarm-baseline)
- [cloudtrail-baseline](./modules/cloudtrail-baseline)
- [guardduty-baseline](./modules/guardduty-baseline)
- [iam-baseline](./modules/iam-baseline)
- [vpc-baseline](./modules/vpc-baseline)
- [secure-bucket](./modules/secure-bucket)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alarm\_namespace | The namespace in which all alarms are set up. | string | `"CISBenchmark"` | no |
| alarm\_sns\_topic\_name | The name of the SNS Topic which will be notified when any alarm is performed. | string | `"CISAlarm"` | no |
| allow\_users\_to\_change\_password | Whether to allow users to change their own password. | string | `"true"` | no |
| audit\_log\_bucket\_name | The name of the S3 bucket to store various audit logs. | string | n/a | yes |
| audit\_log\_lifecycle\_glacier\_transition\_days | The number of days after log creation when the log file is archived into Glacier. | string | `"90"` | no |
| aws\_account\_id | The AWS Account ID number of the account. | string | n/a | yes |
| cloudtrail\_cloudwatch\_logs\_group\_name | The name of CloudWatch Logs group to which CloudTrail events are delivered. | string | `"cloudtrail-multi-region"` | no |
| cloudtrail\_iam\_role\_name | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | string | `"CloudTrail-CloudWatch-Delivery-Role"` | no |
| cloudtrail\_iam\_role\_policy\_name | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | string | `"CloudTrail-CloudWatch-Delivery-Policy"` | no |
| cloudtrail\_key\_deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. | string | `"10"` | no |
| cloudtrail\_name | The name of the trail. | string | `"cloudtrail-multi-region"` | no |
| cloudtrail\_s3\_key\_prefix | The prefix used when CloudTrail delivers events to the S3 bucket. | string | `"cloudtrail"` | no |
| cloudwatch\_logs\_retention\_in\_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | string | `"365"` | no |
| config\_delivery\_frequency | The frequency which AWS Config sends a snapshot into the S3 bucket. | string | `"One_Hour"` | no |
| config\_iam\_role\_name | The name of the IAM Role which AWS Config will use. | string | `"Config-Recorder"` | no |
| config\_iam\_role\_policy\_name | The name of the IAM Role Policy which AWS Config will use. | string | `"Config-Recorder-Policy"` | no |
| config\_s3\_bucket\_key\_prefix | The prefix used when writing AWS Config snapshots into the S3 bucket. | string | `"config"` | no |
| config\_sns\_topic\_name | The name of the SNS Topic to be used to notify configuration changes. | string | `"ConfigChanges"` | no |
| manager\_iam\_role\_name | The name of the IAM Manager role. | string | `"IAM-Manager"` | no |
| manager\_iam\_role\_policy\_name | The name of the IAM Manager role policy. | string | `"IAM-Manager-Policy"` | no |
| master\_iam\_role\_name | The name of the IAM Master role. | string | `"IAM-Master"` | no |
| master\_iam\_role\_policy\_name | The name of the IAM Master role policy. | string | `"IAM-Master-Policy"` | no |
| max\_password\_age | The number of days that an user password is valid. | string | `"90"` | no |
| minimum\_password\_length | Minimum length to require for user passwords. | string | `"14"` | no |
| password\_reuse\_prevention | The number of previous passwords that users are prevented from reusing. | string | `"24"` | no |
| region | The AWS region in which global resources are set up. | string | n/a | yes |
| require\_lowercase\_characters | Whether to require lowercase characters for user passwords. | string | `"true"` | no |
| require\_numbers | Whether to require numbers for user passwords. | string | `"true"` | no |
| require\_symbols | Whether to require symbols for user passwords. | string | `"true"` | no |
| require\_uppercase\_characters | Whether to require uppercase characters for user passwords. | string | `"true"` | no |
| support\_iam\_role\_name | The name of the the support role. | string | `"IAM-Support"` | no |
| support\_iam\_role\_policy\_name | The name of the support role policy. | string | `"IAM-Support-Role"` | no |
| support\_iam\_role\_principal\_arn | The ARN of the IAM principal element by which the support role could be assumed. | string | n/a | yes |
| vpc\_iam\_role\_name | The name of the IAM Role which VPC Flow Logs will use. | string | `"VPC-Flow-Logs-Publisher"` | no |
| vpc\_iam\_role\_policy\_name | The name of the IAM Role Policy which VPC Flow Logs will use. | string | `"VPC-Flow-Logs-Publish-Policy"` | no |
| vpc\_log\_group\_name | The name of CloudWatch Logs group to which VPC Flow Logs are delivered. | string | `"default-vpc-flow-logs"` | no |
| vpc\_log\_retention\_in\_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | string | `"365"` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarms\_topic\_arn | The ARN of the SNS topic to which CloudWatch Alarms will be sent. |
| audit\_bucket\_arn | The ARN of the S3 bucket used for storing audit logs. |
| audit\_bucket\_id | The ID of the S3 bucket used for storing audit logs. |
| cloudtrail\_arn | The ARN of the trail for recording events in all regions. |
| cloudtrail\_id | The ID of the trail for recording events in all regions. |
| cloudtrail\_kms\_key\_arn | The ARN of the KMS key used for encrypting CloudTrail events. |
| cloudtrail\_kms\_key\_id | The ID of the KMS key used for encrypting CloudTrail events. |
| cloudtrail\_log\_delivery\_iam\_role\_arn | The ARN of the IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| cloudtrail\_log\_delivery\_iam\_role\_name | The name of the IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| cloudtrail\_log\_group\_arn | The ARN of the CloudWatch Logs log group which stores CloudTrail events. |
| cloudtrail\_log\_group\_name | The name of the CloudWatch Logs log group which stores CloudTrail events. |
| config\_configuration\_recorder\_id | The name of the configuration recorder. |
| config\_iam\_role\_arn | The ARN of the IAM role used for delivering AWS Config records to CloudWatch Logs. |
| config\_iam\_role\_name | The name of the IAM role used for delivering AWS Config records to CloudWatch Logs. |
| config\_topic\_arn | The ARN of the SNS topic that AWS Config delivers notifications to. |
| default\_network\_acl\_id | The ID of the default network ACL. |
| default\_route\_table\_id | The ID of the default route table. |
| default\_security\_group\_id | The ID of the default security group. |
| default\_vpc\_id | The ID of the default VPC. |
| guardduty\_detector\_id | The ID of the GuardDuty detector. |
| manager\_iam\_role\_arn | The ARN of the IAM role used for the manager user. |
| manager\_iam\_role\_name | The name of the IAM role used for the manager user. |
| master\_iam\_role\_arn | The ARN of the IAM role used for the master user. |
| master\_iam\_role\_name | The name of the IAM role used for the master user. |
| support\_iam\_role\_arn | The ARN of the IAM role used for the support user. |
| support\_iam\_role\_name | The name of the IAM role used for the support user. |
| vpc\_flow\_logs\_group\_arn | The ARN of the CloudWatch Logs log group which stores VPC Flow Logs. |
| vpc\_flow\_logs\_group\_name | The name of the CloudWatch Logs log group which stores VPC Flow Logs. |
| vpc\_flow\_logs\_iam\_role\_arn | The ARN of the IAM role used for delivering VPC Flow Logs to CloudWatch Logs. |
| vpc\_flow\_logs\_iam\_role\_name | The name of the IAM role used for delivering VPC Flow Logs to CloudWatch Logs. |

[CIS Amazon Web Services Foundations]: https://www.cisecurity.org/benchmark/amazon_web_services/
[Providers within Modules - Terraform Docs]: https://www.terraform.io/docs/modules/usage.html#providers-within-modules
[Modules in Package Sub-directories - Terraform]: https://www.terraform.io/docs/modules/sources.html#modules-in-package-sub-directories
