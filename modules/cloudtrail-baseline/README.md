# cloudtrail-baseline

Enable CloudTrail in all regions and deliver events to CloudWatch Logs. CloudTrail logs are encrypted using AWS Key Management Service.

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
| aws\_account\_id | The AWS Account ID number of the account. | `any` | n/a | yes |
| cloudtrail\_depends\_on | External resources which should be set up before CloudTrail. | `list` | `[]` | no |
| cloudtrail\_name | The name of the trail. | `string` | `"cloudtrail-multi-region"` | no |
| cloudtrail\_sns\_topic\_enabled | Specifies whether the trail is delivered to a SNS topic. | `bool` | `true` | no |
| cloudtrail\_sns\_topic\_name | The SNS topic linked to the CloudTrail | `string` | `"cloudtrail-multi-region-sns-topic"` | no |
| cloudwatch\_logs\_enabled | Specifies whether the trail is delivered to CloudWatch Logs. | `bool` | `true` | no |
| cloudwatch\_logs\_group\_name | The name of CloudWatch Logs group to which CloudTrail events are delivered. | `string` | `"cloudtrail-multi-region"` | no |
| cloudwatch\_logs\_retention\_in\_days | Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely. | `number` | `365` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| iam\_role\_name | The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Role"` | no |
| iam\_role\_policy\_name | The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group. | `string` | `"CloudTrail-CloudWatch-Delivery-Policy"` | no |
| is\_organization\_trail | Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account. | `bool` | `false` | no |
| key\_deletion\_window\_in\_days | Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days. | `number` | `10` | no |
| region | The AWS region in which CloudTrail is set up. | `any` | n/a | yes |
| s3\_bucket\_name | The name of the S3 bucket which will store configuration snapshots. | `any` | n/a | yes |
| s3\_key\_prefix | The prefix for the specified S3 bucket. | `string` | `""` | no |
| s3\_object\_level\_logging\_buckets | The list of S3 bucket ARNs on which to enable object-level logging. | `list` | <pre>[<br>  "arn:aws:s3:::"<br>]</pre> | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudtrail | The trail for recording events in all regions. |
| cloudtrail\_sns\_topic | The sns topic linked to the cloudtrail. |
| kms\_key | The  KMS key used for encrypting CloudTrail events. |
| log\_delivery\_iam\_role | The IAM role used for delivering CloudTrail events to CloudWatch Logs. |
| log\_group | The CloudWatch Logs log group which stores CloudTrail events. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
