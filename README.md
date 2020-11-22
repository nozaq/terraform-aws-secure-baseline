# terraform-aws-secure-baseline

[![Github Actions](https://github.com/nozaq/terraform-aws-secure-baseline/workflows/Terraform/badge.svg)](https://github.com/nozaq/terraform-aws-secure-baseline/actions?workflow=Terraform)

[Terraform Module Registry](https://registry.terraform.io/modules/nozaq/secure-baseline/aws)

A terraform module to set up your AWS account with the reasonably secure configuration baseline.
Most configurations are based on [CIS Amazon Web Services Foundations v1.3.0] and [AWS Foundational Security Best Practices v1.0.0].

See [Benchmark Compliance](./compliance.md) to check which items in various benchmarks are covered.

## Features

### Identity and Access Management

- Set up IAM Password Policy.
- Create an IAM role for contacting AWS support for incident handling.
- Enable AWS Config rules to audit root account status.
- Enable IAM Access Analyzer in each region.

### Logging & Monitoring

- Enable CloudTrail in all regions and deliver events to CloudWatch Logs.
- Object-level logging for all S3 buckets is enabled by default.
- CloudTrail logs are encrypted using AWS Key Management Service.
- All logs are stored in the S3 bucket with access logging enabled.
- Logs are automatically archived into Amazon Glacier after the given period(defaults to 90 days).
- Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.
- Enable AWS Config in each regions to automatically take configuration snapshots.
- Enable SecurityHub and subscribe available standards.
- Enable GuardDuty in each regions.

### Networking & Computing

- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.
- Enable AWS Config rules to audit unrestricted common ports in Security Group rules.
- Enable VPC Flow Logs with the default VPC in all regions.
- Enable default EBS encryption for newly created volumes.

## Usage

```hcl
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "secure_baseline" {
  source  = "nozaq/secure-baseline/aws"

  audit_log_bucket_name           = "YOUR_BUCKET_NAME"
  aws_account_id                  = data.aws_caller_identity.current.account_id
  region                          = data.aws_region.current.name
  support_iam_role_principal_arns = ["YOUR_IAM_USER"]

  providers = {
    aws                = aws
    aws.ap-northeast-1 = aws.ap-northeast-1
    aws.ap-northeast-2 = aws.ap-northeast-2
    aws.ap-northeast-3 = aws.ap-northeast-3
    aws.ap-south-1     = aws.ap-south-1
    aws.ap-southeast-1 = aws.ap-southeast-1
    aws.ap-southeast-2 = aws.ap-southeast-2
    aws.ca-central-1   = aws.ca-central-1
    aws.eu-central-1   = aws.eu-central-1
    aws.eu-north-1     = aws.eu-north-1
    aws.eu-west-1      = aws.eu-west-1
    aws.eu-west-2      = aws.eu-west-2
    aws.eu-west-3      = aws.eu-west-3
    aws.sa-east-1      = aws.sa-east-1
    aws.us-east-1      = aws.us-east-1
    aws.us-east-2      = aws.us-east-2
    aws.us-west-1      = aws.us-west-1
    aws.us-west-2      = aws.us-west-2
  }
}
```

Check [the example](./examples/simple/regions.tf) to understand how these providers are defined.
Note that you need to define a provider for each AWS region and pass them to the module. Currently this is the recommended way to handle multiple regions in one module.
Detailed information can be found at [Providers within Modules - Terraform Docs].

A new S3 bucket to store audit logs is automatically created by default, while the external S3 bucket can be specified. It is useful when you already have a centralized S3 bucket to store all logs. Please see [external-bucket](./examples/external-bucket) example for more detail.

### Managing multiple accounts in AWS Organization

When you have multiple AWS accounts in your AWS Organization, `secure-baseline` module configures the separated environment for each AWS account. You can change this behavior to centrally manage security information and audit logs from all accounts in one master account.
Check [organization](./examples/organization) example for more detail.

## Submodules

This module is composed of several submodules and each of which can be used independently.
[Modules in Package Sub-directories - Terraform] describes how to source a submodule.

- [alarm-baseline](./modules/alarm-baseline)
- [analyzer-baseline](./modules/analyzer-baseline)
- [cloudtrail-baseline](./modules/cloudtrail-baseline)
- [config-baseline](./modules/config-baseline)
- [ebs-baseline](./modules/ebs-baseline)
- [guardduty-baseline](./modules/guardduty-baseline)
- [iam-baseline](./modules/iam-baseline)
- [secure-bucket](./modules/secure-bucket)
- [securityhub-baseline](./modules/securityhub-baseline)
- [vpc-baseline](./modules/vpc-baseline)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_type | The type of the AWS account. The possible values are `individual`, `master` and `member` . Specify `master` and `member` to set up centalized logging for multiple accounts in AWS Organization. Use individual` otherwise.` | `string` | `"individual"` | no |
| alarm\_namespace | The namespace in which all alarms are set up. | `string` | `"CISBenchmark"` | no |
| alarm\_sns\_topic\_name | The name of the SNS Topic which will be notified when any alarm is performed. | `string` | `"CISAlarm"` | no |
| allow\_users\_to\_change\_password | Whether to allow users to change their own password. | `bool` | `true` | no |
| analyzer\_name | The name for the IAM Access Analyzer resource to be created. | `string` | `"default-analyer"` | no |
| audit\_log\_bucket\_custom\_policy\_json | Override policy for the audit log bucket. Allows addition of extra policies. | `string` | `"{}"` | no |
| audit\_log\_bucket\_force\_destroy | A boolean that indicates all objects should be deleted from the audit log bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| audit\_log\_bucket\_name | The name of the S3 bucket to store various audit logs. | `any` | n/a | yes |
| audit\_log\_lifecycle\_glacier\_transition\_days | The number of days after log creation when the log file is archived into Glacier. | `number` | `90` | no |
| aws\_account\_id | The AWS Account ID number of the account. | `any` | n/a | yes |
| cloudtrail\_cloudwatch\_logs\_enabled | Specifies whether the trail is delivered to CloudWatch Logs. | `bool` | `true` | no |
| cloudtrail\_cloudwatch\_logs\_group\_name | The name of CloudWatch Logs group to which CloudTrail events are delivered. | `string` | `"cloudtrail-multi-region"` | no |
| cloudtrail\_iam\_role\_name | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Role"` | no |
| cloudtrail\_iam\_role\_policy\_name | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Policy"` | no |
| cloudtrail\_key\_deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. | `number` | `10` | no |
| cloudtrail\_name | The name of the trail. | `string` | `"cloudtrail-multi-region"` | no |
| cloudtrail\_s3\_key\_prefix | The prefix used when CloudTrail delivers events to the S3 bucket. | `string` | `"cloudtrail"` | no |
| cloudtrail\_s3\_object\_level\_logging\_buckets | The list of S3 bucket ARNs on which to enable object-level logging. | `list` | <pre>[<br>  "arn:aws:s3:::"<br>]</pre> | no |
| cloudtrail\_sns\_topic\_enabled | Specifies whether the trail is delivered to a SNS topic. | `bool` | `true` | no |
| cloudtrail\_sns\_topic\_name | The name of the SNS topic to link to the trail. | `string` | `"cloudtrail-multi-region-sns-topic"` | no |
| cloudwatch\_logs\_retention\_in\_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| config\_aggregator\_name | The name of the organizational AWS Config Configuration Aggregator. | `string` | `"organization-aggregator"` | no |
| config\_aggregator\_name\_prefix | The prefix of the name for the IAM role attached to the organizational AWS Config Configuration Aggregator. | `string` | `"config-for-organization-role"` | no |
| config\_delivery\_frequency | The frequency which AWS Config sends a snapshot into the S3 bucket. | `string` | `"One_Hour"` | no |
| config\_iam\_role\_name | The name of the IAM Role which AWS Config will use. | `string` | `"Config-Recorder"` | no |
| config\_iam\_role\_policy\_name | The name of the IAM Role Policy which AWS Config will use. | `string` | `"Config-Recorder-Policy"` | no |
| config\_s3\_bucket\_key\_prefix | The prefix used when writing AWS Config snapshots into the S3 bucket. | `string` | `"config"` | no |
| config\_sns\_topic\_name | The name of the SNS Topic to be used to notify configuration changes. | `string` | `"ConfigChanges"` | no |
| create\_manager\_role | Define if the manager role should be created. | `bool` | `true` | no |
| create\_master\_role | Define if the master role should be created. | `bool` | `true` | no |
| create\_password\_policy | Define if the password policy should be created. | `bool` | `true` | no |
| create\_support\_role | Define if the support role should be created. | `bool` | `true` | no |
| guardduty\_disable\_email\_notification | Boolean whether an email notification is sent to the accounts. | `bool` | `false` | no |
| guardduty\_finding\_publishing\_frequency | Specifies the frequency of notifications sent for subsequent finding occurrences. | `string` | `"SIX_HOURS"` | no |
| guardduty\_invitation\_message | Message for invitation. | `string` | `"This is an automatic invitation message from guardduty-baseline module."` | no |
| manager\_iam\_role\_name | The name of the IAM Manager role. | `string` | `"IAM-Manager"` | no |
| manager\_iam\_role\_policy\_name | The name of the IAM Manager role policy. | `string` | `"IAM-Manager-Policy"` | no |
| master\_account\_id | The ID of the master AWS account to which the current AWS account is associated. Required if `account_type` is `member`. | `string` | `""` | no |
| master\_iam\_role\_name | The name of the IAM Master role. | `string` | `"IAM-Master"` | no |
| master\_iam\_role\_policy\_name | The name of the IAM Master role policy. | `string` | `"IAM-Master-Policy"` | no |
| max\_password\_age | The number of days that an user password is valid. | `number` | `90` | no |
| member\_accounts | A list of IDs and emails of AWS accounts which associated as member accounts. | <pre>list(object({<br>    account_id = string<br>    email      = string<br>  }))</pre> | `[]` | no |
| minimum\_password\_length | Minimum length to require for user passwords. | `number` | `14` | no |
| password\_reuse\_prevention | The number of previous passwords that users are prevented from reusing. | `number` | `24` | no |
| region | The AWS region in which global resources are set up. | `any` | n/a | yes |
| require\_lowercase\_characters | Whether to require lowercase characters for user passwords. | `bool` | `true` | no |
| require\_numbers | Whether to require numbers for user passwords. | `bool` | `true` | no |
| require\_symbols | Whether to require symbols for user passwords. | `bool` | `true` | no |
| require\_uppercase\_characters | Whether to require uppercase characters for user passwords. | `bool` | `true` | no |
| securityhub\_enable\_aws\_foundational\_standard | Boolean whether AWS Foundations standard is enabled. | `bool` | `true` | no |
| securityhub\_enable\_cis\_standard | Boolean whether CIS standard is enabled. | `bool` | `true` | no |
| securityhub\_enable\_pci\_dss\_standard | Boolean whether PCI DSS standard is enabled. | `bool` | `false` | no |
| support\_iam\_role\_name | The name of the the support role. | `string` | `"IAM-Support"` | no |
| support\_iam\_role\_policy\_name | The name of the support role policy. | `string` | `"IAM-Support-Role"` | no |
| support\_iam\_role\_principal\_arns | List of ARNs of the IAM principal elements by which the support role could be assumed. | `list` | n/a | yes |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | `{}` | no |
| target\_regions | A list of regions to set up with this module. | `list` | <pre>[<br>  "ap-northeast-1",<br>  "ap-northeast-2",<br>  "ap-south-1",<br>  "ap-southeast-1",<br>  "ap-southeast-2",<br>  "ca-central-1",<br>  "eu-central-1",<br>  "eu-north-1",<br>  "eu-west-1",<br>  "eu-west-2",<br>  "eu-west-3",<br>  "sa-east-1",<br>  "us-east-1",<br>  "us-east-2",<br>  "us-west-1",<br>  "us-west-2"<br>]</pre> | no |
| use\_external\_audit\_log\_bucket | A boolean that indicates whether the specific audit log bucket already exists. Create a new S3 bucket if it is set to false. | `bool` | `false` | no |
| vpc\_enable\_flow\_logs | The boolean flag whether to enable VPC Flow Logs in default VPCs | `bool` | `true` | no |
| vpc\_flow\_logs\_destination\_type | The type of the logging destination. Valid values: cloud-watch-logs, s3 | `string` | `"cloud-watch-logs"` | no |
| vpc\_flow\_logs\_log\_group\_name | The name of CloudWatch Logs group to which VPC Flow Logs are delivered. | `string` | `"default-vpc-flow-logs"` | no |
| vpc\_flow\_logs\_retention\_in\_days | Number of days to retain logs if vpc\_log\_destination\_type is cloud-watch-logs. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| vpc\_flow\_logs\_s3\_arn | ARN of the S3 bucket to which VPC Flow Logs are delivered if vpc\_log\_destination\_type is s3. | `string` | `""` | no |
| vpc\_flow\_logs\_s3\_key\_prefix | The prefix used when VPC Flow Logs delivers logs to the S3 bucket. | `string` | `"flow-logs"` | no |
| vpc\_iam\_role\_name | The name of the IAM Role which VPC Flow Logs will use. | `string` | `"VPC-Flow-Logs-Publisher"` | no |
| vpc\_iam\_role\_policy\_name | The name of the IAM Role Policy which VPC Flow Logs will use. | `string` | `"VPC-Flow-Logs-Publish-Policy"` | no |

## Outputs

| Name | Description |
|------|-------------|
| alarm\_sns\_topic | The SNS topic to which CloudWatch Alarms will be sent. |
| audit\_bucket | The S3 bucket used for storing audit logs. |
| cloudtrail | The trail for recording events in all regions. |
| cloudtrail\_kms\_key | The KMS key used for encrypting CloudTrail events. |
| cloudtrail\_log\_delivery\_iam\_role | The IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| cloudtrail\_log\_group | The CloudWatch Logs log group which stores CloudTrail events. |
| cloudtrail\_sns\_topic | The sns topic linked to the cloudtrail. |
| config\_configuration\_recorder | The configuration recorder in each region. |
| config\_iam\_role | The IAM role used for delivering AWS Config records to CloudWatch Logs. |
| config\_sns\_topic | The SNS topic that AWS Config delivers notifications to. |
| default\_network\_acl | The default network ACL. |
| default\_route\_table | The default route table. |
| default\_security\_group | The ID of the default security group. |
| default\_vpc | The default VPC. |
| guardduty\_detector | The GuardDuty detector in each region. |
| support\_iam\_role | The IAM role used for the support user. |
| vpc\_flow\_logs\_group | The CloudWatch Logs log group which stores VPC Flow Logs in each region. |
| vpc\_flow\_logs\_iam\_role | The IAM role used for delivering VPC Flow Logs to CloudWatch Logs. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Compatibility

- Starting from v0.20, this module requires [Terraform Provider for AWS](https://github.com/terraform-providers/terraform-provider-aws) v3.0 or later. Please use v0.19 if you need to use v2.x or earlier.
- Starting from v0.10, this module requires Terraform v0.12 or later. Please use v0.9 if you need to use Terraform v0.11 or ealier.


[CIS Amazon Web Services Foundations v1.3.0]: https://www.cisecurity.org/benchmark/amazon_web_services/
[AWS Foundational Security Best Practices v1.0.0]: https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-fsbp.html
[Providers within Modules - Terraform Docs]: https://www.terraform.io/docs/modules/usage.html#providers-within-modules
[Modules in Package Sub-directories - Terraform]: https://www.terraform.io/docs/modules/sources.html#modules-in-package-sub-directories
