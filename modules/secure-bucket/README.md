# secure-bucket

Creates a S3 bucket with access logging enabled.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket_name |  | string | - | yes |
| log_bucket_name |  | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| log_bucket_arn | The ARN of the S3 bucket used for storing access logs of this bucket. |
| log_bucket_id | The ID of the S3 bucket used for storing access logs of this bucket. |
| this_bucket_arn | The ARN of this S3 bucket. |
| this_bucket_id | The ID of this S3 bucket. |

