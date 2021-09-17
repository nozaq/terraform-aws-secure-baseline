# terraform-aws-secure-baseline

[![Github Actions](https://github.com/nozaq/terraform-aws-secure-baseline/workflows/Terraform/badge.svg)](https://github.com/nozaq/terraform-aws-secure-baseline/actions?workflow=Terraform)

[Terraform Module Registry](https://registry.terraform.io/modules/nozaq/secure-baseline/aws)

A terraform module to set up your AWS account with the reasonably secure configuration baseline.
Most configurations are based on [CIS Amazon Web Services Foundations v1.4.0] and [AWS Foundational Security Best Practices v1.0.0].

See [Benchmark Compliance](./compliance.md) to check which items in various benchmarks are covered.

## Features

### Identity and Access Management

- Set up IAM Password Policy.
- Create an IAM role for contacting AWS support for incident handling.
- Enable AWS Config rules to audit root account status.
- Enable IAM Access Analyzer in each region.
- Enable S3 account-level Public Access Block configuration.

### Logging & Monitoring

- Enable CloudTrail in all regions and deliver events to CloudWatch Logs.
- Object-level logging for all S3 buckets is enabled by default.
- CloudTrail Insights event logging is enabled by default.
- CloudTrail logs are encrypted using AWS Key Management Service.
- All logs are stored in the S3 bucket with access logging enabled.
- Logs are automatically archived into Amazon Glacier after the given period(defaults to 90 days).
- Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.
- Enable AWS Config in each regions to automatically take configuration snapshots.
- Enable SecurityHub and subscribe available standards.
- Enable GuardDuty in each regions.

### Networking & Computing

- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.
- Disable automatic public IP assignments in default subnets.
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
- [s3-baseline](./modules/s3-baseline)
- [secure-bucket](./modules/secure-bucket)
- [securityhub-baseline](./modules/securityhub-baseline)
- [vpc-baseline](./modules/vpc-baseline)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.39.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alarm_baseline"></a> [alarm\_baseline](#module\_alarm\_baseline) | ./modules/alarm-baseline | n/a |
| <a name="module_analyzer_baseline_ap-northeast-1"></a> [analyzer\_baseline\_ap-northeast-1](#module\_analyzer\_baseline\_ap-northeast-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_ap-northeast-2"></a> [analyzer\_baseline\_ap-northeast-2](#module\_analyzer\_baseline\_ap-northeast-2) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_ap-northeast-3"></a> [analyzer\_baseline\_ap-northeast-3](#module\_analyzer\_baseline\_ap-northeast-3) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_ap-south-1"></a> [analyzer\_baseline\_ap-south-1](#module\_analyzer\_baseline\_ap-south-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_ap-southeast-1"></a> [analyzer\_baseline\_ap-southeast-1](#module\_analyzer\_baseline\_ap-southeast-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_ap-southeast-2"></a> [analyzer\_baseline\_ap-southeast-2](#module\_analyzer\_baseline\_ap-southeast-2) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_ca-central-1"></a> [analyzer\_baseline\_ca-central-1](#module\_analyzer\_baseline\_ca-central-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_eu-central-1"></a> [analyzer\_baseline\_eu-central-1](#module\_analyzer\_baseline\_eu-central-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_eu-north-1"></a> [analyzer\_baseline\_eu-north-1](#module\_analyzer\_baseline\_eu-north-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_eu-west-1"></a> [analyzer\_baseline\_eu-west-1](#module\_analyzer\_baseline\_eu-west-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_eu-west-2"></a> [analyzer\_baseline\_eu-west-2](#module\_analyzer\_baseline\_eu-west-2) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_eu-west-3"></a> [analyzer\_baseline\_eu-west-3](#module\_analyzer\_baseline\_eu-west-3) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_sa-east-1"></a> [analyzer\_baseline\_sa-east-1](#module\_analyzer\_baseline\_sa-east-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_us-east-1"></a> [analyzer\_baseline\_us-east-1](#module\_analyzer\_baseline\_us-east-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_us-east-2"></a> [analyzer\_baseline\_us-east-2](#module\_analyzer\_baseline\_us-east-2) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_us-west-1"></a> [analyzer\_baseline\_us-west-1](#module\_analyzer\_baseline\_us-west-1) | ./modules/analyzer-baseline | n/a |
| <a name="module_analyzer_baseline_us-west-2"></a> [analyzer\_baseline\_us-west-2](#module\_analyzer\_baseline\_us-west-2) | ./modules/analyzer-baseline | n/a |
| <a name="module_audit_log_bucket"></a> [audit\_log\_bucket](#module\_audit\_log\_bucket) | ./modules/secure-bucket | n/a |
| <a name="module_cloudtrail_baseline"></a> [cloudtrail\_baseline](#module\_cloudtrail\_baseline) | ./modules/cloudtrail-baseline | n/a |
| <a name="module_config_baseline_ap-northeast-1"></a> [config\_baseline\_ap-northeast-1](#module\_config\_baseline\_ap-northeast-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_ap-northeast-2"></a> [config\_baseline\_ap-northeast-2](#module\_config\_baseline\_ap-northeast-2) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_ap-northeast-3"></a> [config\_baseline\_ap-northeast-3](#module\_config\_baseline\_ap-northeast-3) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_ap-south-1"></a> [config\_baseline\_ap-south-1](#module\_config\_baseline\_ap-south-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_ap-southeast-1"></a> [config\_baseline\_ap-southeast-1](#module\_config\_baseline\_ap-southeast-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_ap-southeast-2"></a> [config\_baseline\_ap-southeast-2](#module\_config\_baseline\_ap-southeast-2) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_ca-central-1"></a> [config\_baseline\_ca-central-1](#module\_config\_baseline\_ca-central-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_eu-central-1"></a> [config\_baseline\_eu-central-1](#module\_config\_baseline\_eu-central-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_eu-north-1"></a> [config\_baseline\_eu-north-1](#module\_config\_baseline\_eu-north-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_eu-west-1"></a> [config\_baseline\_eu-west-1](#module\_config\_baseline\_eu-west-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_eu-west-2"></a> [config\_baseline\_eu-west-2](#module\_config\_baseline\_eu-west-2) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_eu-west-3"></a> [config\_baseline\_eu-west-3](#module\_config\_baseline\_eu-west-3) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_sa-east-1"></a> [config\_baseline\_sa-east-1](#module\_config\_baseline\_sa-east-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_us-east-1"></a> [config\_baseline\_us-east-1](#module\_config\_baseline\_us-east-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_us-east-2"></a> [config\_baseline\_us-east-2](#module\_config\_baseline\_us-east-2) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_us-west-1"></a> [config\_baseline\_us-west-1](#module\_config\_baseline\_us-west-1) | ./modules/config-baseline | n/a |
| <a name="module_config_baseline_us-west-2"></a> [config\_baseline\_us-west-2](#module\_config\_baseline\_us-west-2) | ./modules/config-baseline | n/a |
| <a name="module_ebs_baseline_ap-northeast-1"></a> [ebs\_baseline\_ap-northeast-1](#module\_ebs\_baseline\_ap-northeast-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_ap-northeast-2"></a> [ebs\_baseline\_ap-northeast-2](#module\_ebs\_baseline\_ap-northeast-2) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_ap-northeast-3"></a> [ebs\_baseline\_ap-northeast-3](#module\_ebs\_baseline\_ap-northeast-3) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_ap-south-1"></a> [ebs\_baseline\_ap-south-1](#module\_ebs\_baseline\_ap-south-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_ap-southeast-1"></a> [ebs\_baseline\_ap-southeast-1](#module\_ebs\_baseline\_ap-southeast-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_ap-southeast-2"></a> [ebs\_baseline\_ap-southeast-2](#module\_ebs\_baseline\_ap-southeast-2) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_ca-central-1"></a> [ebs\_baseline\_ca-central-1](#module\_ebs\_baseline\_ca-central-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_eu-central-1"></a> [ebs\_baseline\_eu-central-1](#module\_ebs\_baseline\_eu-central-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_eu-north-1"></a> [ebs\_baseline\_eu-north-1](#module\_ebs\_baseline\_eu-north-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_eu-west-1"></a> [ebs\_baseline\_eu-west-1](#module\_ebs\_baseline\_eu-west-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_eu-west-2"></a> [ebs\_baseline\_eu-west-2](#module\_ebs\_baseline\_eu-west-2) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_eu-west-3"></a> [ebs\_baseline\_eu-west-3](#module\_ebs\_baseline\_eu-west-3) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_sa-east-1"></a> [ebs\_baseline\_sa-east-1](#module\_ebs\_baseline\_sa-east-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_us-east-1"></a> [ebs\_baseline\_us-east-1](#module\_ebs\_baseline\_us-east-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_us-east-2"></a> [ebs\_baseline\_us-east-2](#module\_ebs\_baseline\_us-east-2) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_us-west-1"></a> [ebs\_baseline\_us-west-1](#module\_ebs\_baseline\_us-west-1) | ./modules/ebs-baseline | n/a |
| <a name="module_ebs_baseline_us-west-2"></a> [ebs\_baseline\_us-west-2](#module\_ebs\_baseline\_us-west-2) | ./modules/ebs-baseline | n/a |
| <a name="module_guardduty_baseline_ap-northeast-1"></a> [guardduty\_baseline\_ap-northeast-1](#module\_guardduty\_baseline\_ap-northeast-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_ap-northeast-2"></a> [guardduty\_baseline\_ap-northeast-2](#module\_guardduty\_baseline\_ap-northeast-2) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_ap-northeast-3"></a> [guardduty\_baseline\_ap-northeast-3](#module\_guardduty\_baseline\_ap-northeast-3) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_ap-south-1"></a> [guardduty\_baseline\_ap-south-1](#module\_guardduty\_baseline\_ap-south-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_ap-southeast-1"></a> [guardduty\_baseline\_ap-southeast-1](#module\_guardduty\_baseline\_ap-southeast-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_ap-southeast-2"></a> [guardduty\_baseline\_ap-southeast-2](#module\_guardduty\_baseline\_ap-southeast-2) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_ca-central-1"></a> [guardduty\_baseline\_ca-central-1](#module\_guardduty\_baseline\_ca-central-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_eu-central-1"></a> [guardduty\_baseline\_eu-central-1](#module\_guardduty\_baseline\_eu-central-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_eu-north-1"></a> [guardduty\_baseline\_eu-north-1](#module\_guardduty\_baseline\_eu-north-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_eu-west-1"></a> [guardduty\_baseline\_eu-west-1](#module\_guardduty\_baseline\_eu-west-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_eu-west-2"></a> [guardduty\_baseline\_eu-west-2](#module\_guardduty\_baseline\_eu-west-2) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_eu-west-3"></a> [guardduty\_baseline\_eu-west-3](#module\_guardduty\_baseline\_eu-west-3) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_sa-east-1"></a> [guardduty\_baseline\_sa-east-1](#module\_guardduty\_baseline\_sa-east-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_us-east-1"></a> [guardduty\_baseline\_us-east-1](#module\_guardduty\_baseline\_us-east-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_us-east-2"></a> [guardduty\_baseline\_us-east-2](#module\_guardduty\_baseline\_us-east-2) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_us-west-1"></a> [guardduty\_baseline\_us-west-1](#module\_guardduty\_baseline\_us-west-1) | ./modules/guardduty-baseline | n/a |
| <a name="module_guardduty_baseline_us-west-2"></a> [guardduty\_baseline\_us-west-2](#module\_guardduty\_baseline\_us-west-2) | ./modules/guardduty-baseline | n/a |
| <a name="module_iam_baseline"></a> [iam\_baseline](#module\_iam\_baseline) | ./modules/iam-baseline | n/a |
| <a name="module_s3_baseline"></a> [s3\_baseline](#module\_s3\_baseline) | ./modules/s3-baseline | n/a |
| <a name="module_securityhub_baseline_ap-northeast-1"></a> [securityhub\_baseline\_ap-northeast-1](#module\_securityhub\_baseline\_ap-northeast-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_ap-northeast-2"></a> [securityhub\_baseline\_ap-northeast-2](#module\_securityhub\_baseline\_ap-northeast-2) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_ap-northeast-3"></a> [securityhub\_baseline\_ap-northeast-3](#module\_securityhub\_baseline\_ap-northeast-3) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_ap-south-1"></a> [securityhub\_baseline\_ap-south-1](#module\_securityhub\_baseline\_ap-south-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_ap-southeast-1"></a> [securityhub\_baseline\_ap-southeast-1](#module\_securityhub\_baseline\_ap-southeast-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_ap-southeast-2"></a> [securityhub\_baseline\_ap-southeast-2](#module\_securityhub\_baseline\_ap-southeast-2) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_ca-central-1"></a> [securityhub\_baseline\_ca-central-1](#module\_securityhub\_baseline\_ca-central-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_eu-central-1"></a> [securityhub\_baseline\_eu-central-1](#module\_securityhub\_baseline\_eu-central-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_eu-north-1"></a> [securityhub\_baseline\_eu-north-1](#module\_securityhub\_baseline\_eu-north-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_eu-west-1"></a> [securityhub\_baseline\_eu-west-1](#module\_securityhub\_baseline\_eu-west-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_eu-west-2"></a> [securityhub\_baseline\_eu-west-2](#module\_securityhub\_baseline\_eu-west-2) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_eu-west-3"></a> [securityhub\_baseline\_eu-west-3](#module\_securityhub\_baseline\_eu-west-3) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_sa-east-1"></a> [securityhub\_baseline\_sa-east-1](#module\_securityhub\_baseline\_sa-east-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_us-east-1"></a> [securityhub\_baseline\_us-east-1](#module\_securityhub\_baseline\_us-east-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_us-east-2"></a> [securityhub\_baseline\_us-east-2](#module\_securityhub\_baseline\_us-east-2) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_us-west-1"></a> [securityhub\_baseline\_us-west-1](#module\_securityhub\_baseline\_us-west-1) | ./modules/securityhub-baseline | n/a |
| <a name="module_securityhub_baseline_us-west-2"></a> [securityhub\_baseline\_us-west-2](#module\_securityhub\_baseline\_us-west-2) | ./modules/securityhub-baseline | n/a |
| <a name="module_vpc_baseline_ap-northeast-1"></a> [vpc\_baseline\_ap-northeast-1](#module\_vpc\_baseline\_ap-northeast-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_ap-northeast-2"></a> [vpc\_baseline\_ap-northeast-2](#module\_vpc\_baseline\_ap-northeast-2) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_ap-northeast-3"></a> [vpc\_baseline\_ap-northeast-3](#module\_vpc\_baseline\_ap-northeast-3) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_ap-south-1"></a> [vpc\_baseline\_ap-south-1](#module\_vpc\_baseline\_ap-south-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_ap-southeast-1"></a> [vpc\_baseline\_ap-southeast-1](#module\_vpc\_baseline\_ap-southeast-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_ap-southeast-2"></a> [vpc\_baseline\_ap-southeast-2](#module\_vpc\_baseline\_ap-southeast-2) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_ca-central-1"></a> [vpc\_baseline\_ca-central-1](#module\_vpc\_baseline\_ca-central-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_eu-central-1"></a> [vpc\_baseline\_eu-central-1](#module\_vpc\_baseline\_eu-central-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_eu-north-1"></a> [vpc\_baseline\_eu-north-1](#module\_vpc\_baseline\_eu-north-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_eu-west-1"></a> [vpc\_baseline\_eu-west-1](#module\_vpc\_baseline\_eu-west-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_eu-west-2"></a> [vpc\_baseline\_eu-west-2](#module\_vpc\_baseline\_eu-west-2) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_eu-west-3"></a> [vpc\_baseline\_eu-west-3](#module\_vpc\_baseline\_eu-west-3) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_sa-east-1"></a> [vpc\_baseline\_sa-east-1](#module\_vpc\_baseline\_sa-east-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_us-east-1"></a> [vpc\_baseline\_us-east-1](#module\_vpc\_baseline\_us-east-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_us-east-2"></a> [vpc\_baseline\_us-east-2](#module\_vpc\_baseline\_us-east-2) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_us-west-1"></a> [vpc\_baseline\_us-west-1](#module\_vpc\_baseline\_us-west-1) | ./modules/vpc-baseline | n/a |
| <a name="module_vpc_baseline_us-west-2"></a> [vpc\_baseline\_us-west-2](#module\_vpc\_baseline\_us-west-2) | ./modules/vpc-baseline | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_config_config_rule.iam_mfa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.no_policies_with_full_admin_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.unused_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_config_rule.user_no_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_config_rule) | resource |
| [aws_config_configuration_aggregator.organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/config_configuration_aggregator) | resource |
| [aws_iam_role.config_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.flow_logs_publisher](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.recorder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.flow_logs_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.recorder_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.config_organization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.recorder_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket_policy.audit_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.audit_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.audit_log_base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.audit_log_cloud_trail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.audit_log_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.audit_log_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.config_organization_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.flow_logs_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.flow_logs_publisher_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.recorder_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.recorder_publish_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_organizations_organization.org](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_s3_bucket.external](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_type"></a> [account\_type](#input\_account\_type) | The type of the AWS account. The possible values are `individual`, `master` and `member` . Specify `master` and `member` to set up centalized logging for multiple accounts in AWS Organization. Use individual` otherwise.` | `string` | `"individual"` | no |
| <a name="input_alarm_namespace"></a> [alarm\_namespace](#input\_alarm\_namespace) | The namespace in which all alarms are set up. | `string` | `"CISBenchmark"` | no |
| <a name="input_alarm_sns_topic_kms_master_key_id"></a> [alarm\_sns\_topic\_kms\_master\_key\_id](#input\_alarm\_sns\_topic\_kms\_master\_key\_id) | To enable SNS Topic encryption enter value with the ID of a custom master KMS key that is used for encryption | `any` | `null` | no |
| <a name="input_alarm_sns_topic_name"></a> [alarm\_sns\_topic\_name](#input\_alarm\_sns\_topic\_name) | The name of the SNS Topic which will be notified when any alarm is performed. | `string` | `"CISAlarm"` | no |
| <a name="input_allow_users_to_change_password"></a> [allow\_users\_to\_change\_password](#input\_allow\_users\_to\_change\_password) | Whether to allow users to change their own password. | `bool` | `true` | no |
| <a name="input_analyzer_name"></a> [analyzer\_name](#input\_analyzer\_name) | The name for the IAM Access Analyzer resource to be created. | `string` | `"default-analyzer"` | no |
| <a name="input_audit_log_bucket_custom_policy_json"></a> [audit\_log\_bucket\_custom\_policy\_json](#input\_audit\_log\_bucket\_custom\_policy\_json) | Override policy for the audit log bucket. Allows addition of extra policies. | `string` | `"{}"` | no |
| <a name="input_audit_log_bucket_force_destroy"></a> [audit\_log\_bucket\_force\_destroy](#input\_audit\_log\_bucket\_force\_destroy) | A boolean that indicates all objects should be deleted from the audit log bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
| <a name="input_audit_log_bucket_name"></a> [audit\_log\_bucket\_name](#input\_audit\_log\_bucket\_name) | The name of the S3 bucket to store various audit logs. | `any` | n/a | yes |
| <a name="input_audit_log_lifecycle_glacier_transition_days"></a> [audit\_log\_lifecycle\_glacier\_transition\_days](#input\_audit\_log\_lifecycle\_glacier\_transition\_days) | The number of days after log creation when the log file is archived into Glacier. | `number` | `90` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID number of the account. | `any` | n/a | yes |
| <a name="input_aws_config_changes_enabled"></a> [aws\_config\_changes\_enabled](#input\_aws\_config\_changes\_enabled) | The boolean flag whether the aws\_config\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_cloudtrail_cfg_changes_enabled"></a> [cloudtrail\_cfg\_changes\_enabled](#input\_cloudtrail\_cfg\_changes\_enabled) | The boolean flag whether the cloudtrail\_cfg\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_cloudtrail_cloudwatch_logs_enabled"></a> [cloudtrail\_cloudwatch\_logs\_enabled](#input\_cloudtrail\_cloudwatch\_logs\_enabled) | Specifies whether the trail is delivered to CloudWatch Logs. | `bool` | `true` | no |
| <a name="input_cloudtrail_cloudwatch_logs_group_name"></a> [cloudtrail\_cloudwatch\_logs\_group\_name](#input\_cloudtrail\_cloudwatch\_logs\_group\_name) | The name of CloudWatch Logs group to which CloudTrail events are delivered. | `string` | `"cloudtrail-multi-region"` | no |
| <a name="input_cloudtrail_dynamodb_event_logging_tables"></a> [cloudtrail\_dynamodb\_event\_logging\_tables](#input\_cloudtrail\_dynamodb\_event\_logging\_tables) | The list of DynamoDB table ARNs on which to enable event logging. | `list` | <pre>[<br>  "arn:aws:dynamodb"<br>]</pre> | no |
| <a name="input_cloudtrail_iam_role_name"></a> [cloudtrail\_iam\_role\_name](#input\_cloudtrail\_iam\_role\_name) | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Role"` | no |
| <a name="input_cloudtrail_iam_role_policy_name"></a> [cloudtrail\_iam\_role\_policy\_name](#input\_cloudtrail\_iam\_role\_policy\_name) | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Policy"` | no |
| <a name="input_cloudtrail_key_deletion_window_in_days"></a> [cloudtrail\_key\_deletion\_window\_in\_days](#input\_cloudtrail\_key\_deletion\_window\_in\_days) | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. | `number` | `10` | no |
| <a name="input_cloudtrail_lambda_invocation_logging_lambdas"></a> [cloudtrail\_lambda\_invocation\_logging\_lambdas](#input\_cloudtrail\_lambda\_invocation\_logging\_lambdas) | The list of lambda ARNs on which to enable invocation logging. | `list` | <pre>[<br>  "arn:aws:lambda"<br>]</pre> | no |
| <a name="input_cloudtrail_name"></a> [cloudtrail\_name](#input\_cloudtrail\_name) | The name of the trail. | `string` | `"cloudtrail-multi-region"` | no |
| <a name="input_cloudtrail_s3_key_prefix"></a> [cloudtrail\_s3\_key\_prefix](#input\_cloudtrail\_s3\_key\_prefix) | The prefix used when CloudTrail delivers events to the S3 bucket. | `string` | `"cloudtrail"` | no |
| <a name="input_cloudtrail_s3_object_level_logging_buckets"></a> [cloudtrail\_s3\_object\_level\_logging\_buckets](#input\_cloudtrail\_s3\_object\_level\_logging\_buckets) | The list of S3 bucket ARNs on which to enable object-level logging. | `list` | <pre>[<br>  "arn:aws:s3:::"<br>]</pre> | no |
| <a name="input_cloudtrail_sns_topic_enabled"></a> [cloudtrail\_sns\_topic\_enabled](#input\_cloudtrail\_sns\_topic\_enabled) | Specifies whether the trail is delivered to a SNS topic. | `bool` | `true` | no |
| <a name="input_cloudtrail_sns_topic_name"></a> [cloudtrail\_sns\_topic\_name](#input\_cloudtrail\_sns\_topic\_name) | The name of the SNS topic to link to the trail. | `string` | `"cloudtrail-multi-region-sns-topic"` | no |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| <a name="input_config_aggregator_name"></a> [config\_aggregator\_name](#input\_config\_aggregator\_name) | The name of the organizational AWS Config Configuration Aggregator. | `string` | `"organization-aggregator"` | no |
| <a name="input_config_aggregator_name_prefix"></a> [config\_aggregator\_name\_prefix](#input\_config\_aggregator\_name\_prefix) | The prefix of the name for the IAM role attached to the organizational AWS Config Configuration Aggregator. | `string` | `"config-for-organization-role"` | no |
| <a name="input_config_baseline_enabled"></a> [config\_baseline\_enabled](#input\_config\_baseline\_enabled) | Boolean whether config-baseline is enabled. | `bool` | `true` | no |
| <a name="input_config_delivery_frequency"></a> [config\_delivery\_frequency](#input\_config\_delivery\_frequency) | The frequency which AWS Config sends a snapshot into the S3 bucket. | `string` | `"One_Hour"` | no |
| <a name="input_config_global_resources_all_regions"></a> [config\_global\_resources\_all\_regions](#input\_config\_global\_resources\_all\_regions) | Record global resources in all regions. If false, only default region will record global resources. | `bool` | `false` | no |
| <a name="input_config_iam_role_name"></a> [config\_iam\_role\_name](#input\_config\_iam\_role\_name) | The name of the IAM Role which AWS Config will use. | `string` | `"Config-Recorder"` | no |
| <a name="input_config_iam_role_policy_name"></a> [config\_iam\_role\_policy\_name](#input\_config\_iam\_role\_policy\_name) | The name of the IAM Role Policy which AWS Config will use. | `string` | `"Config-Recorder-Policy"` | no |
| <a name="input_config_s3_bucket_key_prefix"></a> [config\_s3\_bucket\_key\_prefix](#input\_config\_s3\_bucket\_key\_prefix) | The prefix used when writing AWS Config snapshots into the S3 bucket. | `string` | `"config"` | no |
| <a name="input_config_sns_topic_kms_master_key_id"></a> [config\_sns\_topic\_kms\_master\_key\_id](#input\_config\_sns\_topic\_kms\_master\_key\_id) | To enable SNS Topic encryption enter value with the ID of a custom master KMS key that is used for encryption | `any` | `null` | no |
| <a name="input_config_sns_topic_name"></a> [config\_sns\_topic\_name](#input\_config\_sns\_topic\_name) | The name of the SNS Topic to be used to notify configuration changes. | `string` | `"ConfigChanges"` | no |
| <a name="input_console_signin_failures_enabled"></a> [console\_signin\_failures\_enabled](#input\_console\_signin\_failures\_enabled) | The boolean flag whether the console\_signin\_failures alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_create_manager_role"></a> [create\_manager\_role](#input\_create\_manager\_role) | Define if the manager role should be created. | `bool` | `true` | no |
| <a name="input_create_master_role"></a> [create\_master\_role](#input\_create\_master\_role) | Define if the master role should be created. | `bool` | `true` | no |
| <a name="input_create_password_policy"></a> [create\_password\_policy](#input\_create\_password\_policy) | Define if the password policy should be created. | `bool` | `true` | no |
| <a name="input_create_support_role"></a> [create\_support\_role](#input\_create\_support\_role) | Define if the support role should be created. | `bool` | `true` | no |
| <a name="input_disable_or_delete_cmk_enabled"></a> [disable\_or\_delete\_cmk\_enabled](#input\_disable\_or\_delete\_cmk\_enabled) | The boolean flag whether the disable\_or\_delete\_cmk alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_guardduty_disable_email_notification"></a> [guardduty\_disable\_email\_notification](#input\_guardduty\_disable\_email\_notification) | Boolean whether an email notification is sent to the accounts. | `bool` | `false` | no |
| <a name="input_guardduty_enabled"></a> [guardduty\_enabled](#input\_guardduty\_enabled) | Boolean whether the guardduty-baseline module is enabled or disabled | `bool` | `true` | no |
| <a name="input_guardduty_finding_publishing_frequency"></a> [guardduty\_finding\_publishing\_frequency](#input\_guardduty\_finding\_publishing\_frequency) | Specifies the frequency of notifications sent for subsequent finding occurrences. | `string` | `"SIX_HOURS"` | no |
| <a name="input_guardduty_invitation_message"></a> [guardduty\_invitation\_message](#input\_guardduty\_invitation\_message) | Message for invitation. | `string` | `"This is an automatic invitation message from guardduty-baseline module."` | no |
| <a name="input_iam_changes_enabled"></a> [iam\_changes\_enabled](#input\_iam\_changes\_enabled) | The boolean flag whether the iam\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_manager_iam_role_name"></a> [manager\_iam\_role\_name](#input\_manager\_iam\_role\_name) | The name of the IAM Manager role. | `string` | `"IAM-Manager"` | no |
| <a name="input_manager_iam_role_policy_name"></a> [manager\_iam\_role\_policy\_name](#input\_manager\_iam\_role\_policy\_name) | The name of the IAM Manager role policy. | `string` | `"IAM-Manager-Policy"` | no |
| <a name="input_master_account_id"></a> [master\_account\_id](#input\_master\_account\_id) | The ID of the master AWS account to which the current AWS account is associated. Required if `account_type` is `member`. | `string` | `""` | no |
| <a name="input_master_iam_role_name"></a> [master\_iam\_role\_name](#input\_master\_iam\_role\_name) | The name of the IAM Master role. | `string` | `"IAM-Master"` | no |
| <a name="input_master_iam_role_policy_name"></a> [master\_iam\_role\_policy\_name](#input\_master\_iam\_role\_policy\_name) | The name of the IAM Master role policy. | `string` | `"IAM-Master-Policy"` | no |
| <a name="input_max_password_age"></a> [max\_password\_age](#input\_max\_password\_age) | The number of days that an user password is valid. | `number` | `0` | no |
| <a name="input_member_accounts"></a> [member\_accounts](#input\_member\_accounts) | A list of IDs and emails of AWS accounts which associated as member accounts. | <pre>list(object({<br>    account_id = string<br>    email      = string<br>  }))</pre> | `[]` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Minimum length to require for user passwords. | `number` | `14` | no |
| <a name="input_nacl_changes_enabled"></a> [nacl\_changes\_enabled](#input\_nacl\_changes\_enabled) | The boolean flag whether the nacl\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_network_gw_changes_enabled"></a> [network\_gw\_changes\_enabled](#input\_network\_gw\_changes\_enabled) | The boolean flag whether the network\_gw\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_no_mfa_console_signin_enabled"></a> [no\_mfa\_console\_signin\_enabled](#input\_no\_mfa\_console\_signin\_enabled) | The boolean flag whether the no\_mfa\_console\_signin alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_organizations_changes_enabled"></a> [organizations\_changes\_enabled](#input\_organizations\_changes\_enabled) | The boolean flag whether the organizations\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_password_reuse_prevention"></a> [password\_reuse\_prevention](#input\_password\_reuse\_prevention) | The number of previous passwords that users are prevented from reusing. | `number` | `24` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region in which global resources are set up. | `any` | n/a | yes |
| <a name="input_require_lowercase_characters"></a> [require\_lowercase\_characters](#input\_require\_lowercase\_characters) | Whether to require lowercase characters for user passwords. | `bool` | `false` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether to require numbers for user passwords. | `bool` | `false` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether to require symbols for user passwords. | `bool` | `false` | no |
| <a name="input_require_uppercase_characters"></a> [require\_uppercase\_characters](#input\_require\_uppercase\_characters) | Whether to require uppercase characters for user passwords. | `bool` | `false` | no |
| <a name="input_root_usage_enabled"></a> [root\_usage\_enabled](#input\_root\_usage\_enabled) | The boolean flag whether the root\_usage alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_route_table_changes_enabled"></a> [route\_table\_changes\_enabled](#input\_route\_table\_changes\_enabled) | The boolean flag whether the route\_table\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_s3_block_public_acls"></a> [s3\_block\_public\_acls](#input\_s3\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_s3_block_public_policy"></a> [s3\_block\_public\_policy](#input\_s3\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_s3_bucket_policy_changes_enabled"></a> [s3\_bucket\_policy\_changes\_enabled](#input\_s3\_bucket\_policy\_changes\_enabled) | The boolean flag whether the s3\_bucket\_policy\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_s3_ignore_public_acls"></a> [s3\_ignore\_public\_acls](#input\_s3\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_s3_restrict_public_buckets"></a> [s3\_restrict\_public\_buckets](#input\_s3\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for buckets in this account. Defaults to true. | `bool` | `true` | no |
| <a name="input_security_group_changes_enabled"></a> [security\_group\_changes\_enabled](#input\_security\_group\_changes\_enabled) | The boolean flag whether the security\_group\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_securityhub_enable_aws_foundational_standard"></a> [securityhub\_enable\_aws\_foundational\_standard](#input\_securityhub\_enable\_aws\_foundational\_standard) | Boolean whether AWS Foundations standard is enabled. | `bool` | `true` | no |
| <a name="input_securityhub_enable_cis_standard"></a> [securityhub\_enable\_cis\_standard](#input\_securityhub\_enable\_cis\_standard) | Boolean whether CIS standard is enabled. | `bool` | `true` | no |
| <a name="input_securityhub_enable_pci_dss_standard"></a> [securityhub\_enable\_pci\_dss\_standard](#input\_securityhub\_enable\_pci\_dss\_standard) | Boolean whether PCI DSS standard is enabled. | `bool` | `false` | no |
| <a name="input_securityhub_enable_product_arns"></a> [securityhub\_enable\_product\_arns](#input\_securityhub\_enable\_product\_arns) | List of Security Hub product ARNs, `<REGION>` will be replaced. See https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-partner-providers.html for list. | `list(string)` | `[]` | no |
| <a name="input_securityhub_enabled"></a> [securityhub\_enabled](#input\_securityhub\_enabled) | Boolean whether the securityhub-baseline module is enabled or disabled | `bool` | `true` | no |
| <a name="input_support_iam_role_name"></a> [support\_iam\_role\_name](#input\_support\_iam\_role\_name) | The name of the the support role. | `string` | `"IAM-Support"` | no |
| <a name="input_support_iam_role_policy_name"></a> [support\_iam\_role\_policy\_name](#input\_support\_iam\_role\_policy\_name) | The name of the support role policy. | `string` | `"IAM-Support-Role"` | no |
| <a name="input_support_iam_role_principal_arns"></a> [support\_iam\_role\_principal\_arns](#input\_support\_iam\_role\_principal\_arns) | List of ARNs of the IAM principal elements by which the support role could be assumed. | `list(any)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map` | `{}` | no |
| <a name="input_target_regions"></a> [target\_regions](#input\_target\_regions) | A list of regions to set up with this module. | `list` | <pre>[<br>  "ap-northeast-1",<br>  "ap-northeast-2",<br>  "ap-northeast-3",<br>  "ap-south-1",<br>  "ap-southeast-1",<br>  "ap-southeast-2",<br>  "ca-central-1",<br>  "eu-central-1",<br>  "eu-north-1",<br>  "eu-west-1",<br>  "eu-west-2",<br>  "eu-west-3",<br>  "sa-east-1",<br>  "us-east-1",<br>  "us-east-2",<br>  "us-west-1",<br>  "us-west-2"<br>]</pre> | no |
| <a name="input_unauthorized_api_calls_enabled"></a> [unauthorized\_api\_calls\_enabled](#input\_unauthorized\_api\_calls\_enabled) | The boolean flag whether the unauthorized\_api\_calls alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_use_external_audit_log_bucket"></a> [use\_external\_audit\_log\_bucket](#input\_use\_external\_audit\_log\_bucket) | A boolean that indicates whether the specific audit log bucket already exists. Create a new S3 bucket if it is set to false. | `bool` | `false` | no |
| <a name="input_vpc_changes_enabled"></a> [vpc\_changes\_enabled](#input\_vpc\_changes\_enabled) | The boolean flag whether the vpc\_changes alarm is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_vpc_enable"></a> [vpc\_enable](#input\_vpc\_enable) | Boolean whether the VPC baseline module should be enabled | `bool` | `true` | no |
| <a name="input_vpc_enable_flow_logs"></a> [vpc\_enable\_flow\_logs](#input\_vpc\_enable\_flow\_logs) | The boolean flag whether to enable VPC Flow Logs in default VPCs | `bool` | `true` | no |
| <a name="input_vpc_flow_logs_destination_type"></a> [vpc\_flow\_logs\_destination\_type](#input\_vpc\_flow\_logs\_destination\_type) | The type of the logging destination. Valid values: cloud-watch-logs, s3 | `string` | `"cloud-watch-logs"` | no |
| <a name="input_vpc_flow_logs_log_group_name"></a> [vpc\_flow\_logs\_log\_group\_name](#input\_vpc\_flow\_logs\_log\_group\_name) | The name of CloudWatch Logs group to which VPC Flow Logs are delivered. | `string` | `"default-vpc-flow-logs"` | no |
| <a name="input_vpc_flow_logs_retention_in_days"></a> [vpc\_flow\_logs\_retention\_in\_days](#input\_vpc\_flow\_logs\_retention\_in\_days) | Number of days to retain logs if vpc\_log\_destination\_type is cloud-watch-logs. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| <a name="input_vpc_flow_logs_s3_arn"></a> [vpc\_flow\_logs\_s3\_arn](#input\_vpc\_flow\_logs\_s3\_arn) | ARN of the S3 bucket to which VPC Flow Logs are delivered if vpc\_log\_destination\_type is s3. | `string` | `""` | no |
| <a name="input_vpc_flow_logs_s3_key_prefix"></a> [vpc\_flow\_logs\_s3\_key\_prefix](#input\_vpc\_flow\_logs\_s3\_key\_prefix) | The prefix used when VPC Flow Logs delivers logs to the S3 bucket. | `string` | `"flow-logs"` | no |
| <a name="input_vpc_iam_role_name"></a> [vpc\_iam\_role\_name](#input\_vpc\_iam\_role\_name) | The name of the IAM Role which VPC Flow Logs will use. | `string` | `"VPC-Flow-Logs-Publisher"` | no |
| <a name="input_vpc_iam_role_policy_name"></a> [vpc\_iam\_role\_policy\_name](#input\_vpc\_iam\_role\_policy\_name) | The name of the IAM Role Policy which VPC Flow Logs will use. | `string` | `"VPC-Flow-Logs-Publish-Policy"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alarm_sns_topic"></a> [alarm\_sns\_topic](#output\_alarm\_sns\_topic) | The SNS topic to which CloudWatch Alarms will be sent. |
| <a name="output_audit_bucket"></a> [audit\_bucket](#output\_audit\_bucket) | The S3 bucket used for storing audit logs. |
| <a name="output_cloudtrail"></a> [cloudtrail](#output\_cloudtrail) | The trail for recording events in all regions. |
| <a name="output_cloudtrail_kms_key"></a> [cloudtrail\_kms\_key](#output\_cloudtrail\_kms\_key) | The KMS key used for encrypting CloudTrail events. |
| <a name="output_cloudtrail_log_delivery_iam_role"></a> [cloudtrail\_log\_delivery\_iam\_role](#output\_cloudtrail\_log\_delivery\_iam\_role) | The IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| <a name="output_cloudtrail_log_group"></a> [cloudtrail\_log\_group](#output\_cloudtrail\_log\_group) | The CloudWatch Logs log group which stores CloudTrail events. |
| <a name="output_cloudtrail_sns_topic"></a> [cloudtrail\_sns\_topic](#output\_cloudtrail\_sns\_topic) | The sns topic linked to the cloudtrail. |
| <a name="output_config_configuration_recorder"></a> [config\_configuration\_recorder](#output\_config\_configuration\_recorder) | The configuration recorder in each region. |
| <a name="output_config_iam_role"></a> [config\_iam\_role](#output\_config\_iam\_role) | The IAM role used for delivering AWS Config records to CloudWatch Logs. |
| <a name="output_config_sns_topic"></a> [config\_sns\_topic](#output\_config\_sns\_topic) | The SNS topic that AWS Config delivers notifications to. |
| <a name="output_default_network_acl"></a> [default\_network\_acl](#output\_default\_network\_acl) | The default network ACL. |
| <a name="output_default_route_table"></a> [default\_route\_table](#output\_default\_route\_table) | The default route table. |
| <a name="output_default_security_group"></a> [default\_security\_group](#output\_default\_security\_group) | The ID of the default security group. |
| <a name="output_default_vpc"></a> [default\_vpc](#output\_default\_vpc) | The default VPC. |
| <a name="output_guardduty_detector"></a> [guardduty\_detector](#output\_guardduty\_detector) | The GuardDuty detector in each region. |
| <a name="output_support_iam_role"></a> [support\_iam\_role](#output\_support\_iam\_role) | The IAM role used for the support user. |
| <a name="output_vpc_flow_logs_group"></a> [vpc\_flow\_logs\_group](#output\_vpc\_flow\_logs\_group) | The CloudWatch Logs log group which stores VPC Flow Logs in each region. |
| <a name="output_vpc_flow_logs_iam_role"></a> [vpc\_flow\_logs\_iam\_role](#output\_vpc\_flow\_logs\_iam\_role) | The IAM role used for delivering VPC Flow Logs to CloudWatch Logs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Compatibility

- Starting from v0.20, this module requires [Terraform Provider for AWS](https://github.com/terraform-providers/terraform-provider-aws) v3.0 or later. Please use v0.19 if you need to use v2.x or earlier.
- Starting from v0.10, this module requires Terraform v0.12 or later. Please use v0.9 if you need to use Terraform v0.11 or ealier.

[cis amazon web services foundations v1.4.0]: https://www.cisecurity.org/benchmark/amazon_web_services/
[aws foundational security best practices v1.0.0]: https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-fsbp.html
[providers within modules - terraform docs]: https://www.terraform.io/docs/modules/usage.html#providers-within-modules
[modules in package sub-directories - terraform]: https://www.terraform.io/docs/modules/sources.html#modules-in-package-sub-directories
