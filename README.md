# terraform-aws-secure-baseline

[Terraform Module Registry](https://registry.terraform.io/modules/nozaq/secure-baseline/aws)

A terraform module to set up your AWS account with the reasonably secure configuration baseline.
Most configurations are based on [CIS Amazon web Services Foundations].

## Features

- Set up IAM Password Policy.
- Enable CloudTrail with KMS encryption in all regions and deliver events to CloudWatch Logs.
- Enable AWS Config in all regions to automatically take configuration snapshots.
- All logs are stored in the S3 bucket with access logging enabled.
- Set up CloudWatch alarms to notify you when critical changes happen in your AWS account.
- Enable VPC Flow Logs with the default VPC in all regions.
- Remove all rules in default route tables, default network ACLs and default security groups in the default VPC in all regions.

## Usage

```hcl
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

module "secure-baseline" {
  source  = "nozaq/secure-baseline/aws"

  audit_log_bucket_name = "YOUR_BUCKET_NAME"
  aws_account_id = "${data.aws_caller_identity.current.account_id}"
  region = "${data.aws_region.current.name}"
}
```

[CIS Amazon Web Services Foundations]: https://d0.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf