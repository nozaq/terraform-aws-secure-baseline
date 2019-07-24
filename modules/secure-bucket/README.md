# secure-bucket

Creates a S3 bucket with access logging enabled.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket\_name |  | string | n/a | yes |
| enabled | A boolean that indicates this module is enabled. Resources are not created if it is set to false. | string | `"true"` | no |
| force\_destroy | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | string | `"false"` | no |
| lifecycle\_glacier\_transition\_days | The number of days after object creation when the object is archived into Glacier. | string | `"90"` | no |
| log\_bucket\_name |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| log\_bucket | The S3 bucket used for storing access logs of this bucket. |
| this\_bucket | This S3 bucket. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
