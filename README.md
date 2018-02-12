# terraform-aws-secure-baseline

[![CircleCI](https://circleci.com/gh/nozaq/terraform-aws-secure-baseline.svg?style=svg)](https://circleci.com/gh/nozaq/terraform-aws-secure-baseline)

[Terraform Module Registry](https://registry.terraform.io/modules/nozaq/secure-baseline/aws)

A terraform module to set up your AWS account with the reasonably secure configuration baseline.
Most configurations are based on [CIS Amazon web Services Foundations].

## Features

- Set up IAM Password Policy.
- Enable CloudTrail in all regions and deliver events to CloudWatch Logs.
- CloudTrail logs are encrypted using AWS Key Management Service.
- Enable AWS Config in all regions to automatically take configuration snapshots.
- All logs are stored in the S3 bucket with access logging enabled.
- Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.
- Enable VPC Flow Logs with the default VPC in all regions.
- Remove all rules associated with default route tables, default network ACLs and default security groups in the default VPC in all regions.
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

Note that you need to define a provider for each AWS region and pass them to the module.
Currently this is the recommended way to handle multiple regions in one module.
Detailed information can be found at [Providers within Modules - Terraform Docs].

[CIS Amazon Web Services Foundations]: https://d0.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf
[Providers within Modules - Terraform Docs]: https://www.terraform.io/docs/modules/usage.html#providers-within-modules