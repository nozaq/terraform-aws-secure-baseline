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
| log_bucket | The S3 bucket used for storing access logs of this bucket. |
| this_bucket | This S3 bucket. |
