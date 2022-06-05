# secure-bucket

Creates a S3 bucket with access logging enabled.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.3 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the S3 bucket to create. | `string` | yes |
| <a name="input_log_bucket_name"></a> [log\_bucket\_name](#input\_log\_bucket\_name) | The name of the S3 bucket to store access logs to the main bucket. | `string` | yes |
| <a name="input_bucket_key_enabled"></a> [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | Whether or not to use Amazon S3 Bucket Keys for this bucket. | `bool` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | no |
| <a name="input_lifecycle_glacier_transition_days"></a> [lifecycle\_glacier\_transition\_days](#input\_lifecycle\_glacier\_transition\_days) | The number of days after object creation when the object is archived into Glacier.  Setting to zero disables the transition. | `number` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_bucket"></a> [log\_bucket](#output\_log\_bucket) | The S3 bucket used for storing access logs of this bucket. |
| <a name="output_this_bucket"></a> [this\_bucket](#output\_this\_bucket) | This S3 bucket. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
