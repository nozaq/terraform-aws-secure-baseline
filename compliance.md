# Benchmark Compliance

The table below shows which items in [CIS Amazon web Services Foundations] v1.2.0 are covered in this module.

## Definition

Implementation status for each item is categorized as follows. 

| Status | Description |
| ------ | ----------- |
| OK | This module ensure that the requirements for this item are satisfied. |
| N/A | This module has nothing to do with the requirements for this item. |

## CIS Amazon Web Services Foundations v1.2.0

| No. | Item | Status | Notes |
| ---:| ---- | ------ | ----- |
| 1.1  | Avoid the use of the "root" account | N/A | |
| 1.2  | Ensure multi-factor authentication (MFA) is enabled for all IAM users that have a console password | N/A | |
| 1.3  | Ensure credentials unused for 90 days or greater are disabled | N/A | |
| 1.4  | Ensure access keys are rotated every 90 days or less | N/A | |
| 1.5  | Ensure IAM password policy requires at least one uppercase letter | OK | |
| 1.6  | Ensure IAM password policy require at least one lowercase letter | OK | |
| 1.7  | Ensure IAM password policy require at least one symbol | OK | |
| 1.8  | Ensure IAM password policy require at least one number | OK | |
| 1.9  | Ensure IAM password policy requires minimum length of 14 or greater | OK | |
| 1.10 | Ensure IAM password policy prevents password reuse | OK | |
| 1.11 | Ensure IAM password policy expires passwords within 90 days or less | OK | |
| 1.12 | Ensure no root account access key exists | N/A | | |
| 1.13 | Ensure MFA is enabled for the "root" account | OK | Although this module does not enforce the use of MFA, it enables a AWS Config rule to monitor that the MFA is enabled for root account. |
| 1.14 | Ensure hardware MFA is enabled for the "root" account | N/A | |
| 1.15 | Ensure security questions are registered in the AWS account | N/A | |
| 1.16 | Ensure IAM policies are attached only to groups or roles | N/A | |
| 1.17 | Maintain current contact details | N/A | |
| 1.18 | Ensure security contact information is registered | N/A | |
| 1.19 | Ensure IAM instance roles are used for AWS resource access from instances | N/A | |
| 1.20 | Ensure a support role has been created to manage incidents with AWS Support | OK | |
| 1.21 | Do not setup access keys during initial user setup for all IAM users that have a console password | N/A | |
| 1.22 | Ensure IAM policies that allow full "*:*" administrative privileges are not created | N/A | |
| 2.1  | Ensure CloudTrail is enabled in all regions | OK | |
| 2.2  | Ensure CloudTrail log file validation is enabled | OK | |
| 2.3  | Ensure the S3 bucket used to store CloudTrail logs is not publicly accessible | OK | |
| 2.4  | Ensure CloudTrail trails are integrated with CloudWatch Logs | OK | |
| 2.5  | Ensure AWS Config is enabled in all regions | OK | |
| 2.6  | Ensure S3 bucket access logging is enabled on the CloudTrail S3 bucket | OK | |
| 2.7  | Ensure CloudTrail logs are encrypted at rest using KMS CMKs | OK | |
| 2.8  | Ensure rotation for customer created CMKs is enabled | OK | |
| 2.9  | Ensure VPC flow logging is enabled in all VPCs | OK | |
| 3.1  | Ensure a log metric filter and alarm exist for unauthorized API calls | OK | |
| 3.2  | Ensure a log metric filter and alarm exist for Management Console sign-in without MFA | OK | |
| 3.3  | Ensure a log metric filter and alarm exist for usage of "root" account | OK | |
| 3.4  | Ensure a log metric filter and alarm exist for IAM policy changes | OK | |
| 3.5  | Ensure a log metric filter and alarm exist for CloudTrail configuration changes | OK | |
| 3.6  | Ensure a log metric filter and alarm exist for AWS Management Console authentication failures | OK | |
| 3.7  | Ensure a log metric filter and alarm exist for disabling or scheduled deletion of customer created CMKs | OK | |
| 3.8  | Ensure a log metric filter and alarm exist for S3 bucket policy changes | OK | |
| 3.9  | Ensure a log metric filter and alarm exist for AWS Config configuration changes | OK | |
| 3.10 | Ensure a log metric filter and alarm exist for security group changes | OK | |
| 3.11 | Ensure a log metric filter and alarm exist for changes to Network Access Control Lists (NACL) | OK | |
| 3.12 | Ensure a log metric filter and alarm exist for changes to network gateways | OK | |
| 3.13 | Ensure a log metric filter and alarm exist for route table changes | OK | |
| 3.14 | Ensure a log metric filter and alarm exist for VPC changes | OK | |
| 4.1  | Ensure no security groups allow ingress from 0.0.0.0/0 to port 22 | OK | Monitored by the AWS Config rule. |
| 4.2  | Ensure no security groups allow ingress from 0.0.0.0/0 to port 3389 | OK | Monitored by the AWS Config rule. |
| 4.3  | Ensure the default security group of every VPC restricts all traffic | OK | |
| 4.4  | Ensure routing tables for VPC peering are "least access" | N/A | |

[CIS Amazon Web Services Foundations]: https://www.cisecurity.org/benchmark/amazon_web_services/
