# iam-baseline

## Features

- Set up IAM Password Policy.
- Create default IAM roles for managing AWS account.

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
| allow\_users\_to\_change\_password | Whether to allow users to change their own password. | `bool` | `true` | no |
| aws\_account\_id | The AWS Account ID number of the account. | `any` | n/a | yes |
| create\_password\_policy | Define if the password policy should be created. | `bool` | `true` | no |
| create\_support\_role | Define if the support role should be created. | `bool` | `true` | no |
| max\_password\_age | The number of days that an user password is valid. | `number` | `90` | no |
| minimum\_password\_length | Minimum length to require for user passwords. | `number` | `14` | no |
| password\_reuse\_prevention | The number of previous passwords that users are prevented from reusing. | `number` | `24` | no |
| require\_lowercase\_characters | Whether to require lowercase characters for user passwords. | `bool` | `true` | no |
| require\_numbers | Whether to require numbers for user passwords. | `bool` | `true` | no |
| require\_symbols | Whether to require symbols for user passwords. | `bool` | `true` | no |
| require\_uppercase\_characters | Whether to require uppercase characters for user passwords. | `bool` | `true` | no |
| support\_iam\_role\_name | The name of the the support role. | `string` | `"IAM-Support"` | no |
| support\_iam\_role\_policy\_name | The name of the support role policy. | `string` | `"IAM-Support-Role"` | no |
| support\_iam\_role\_principal\_arns | List of ARNs of the IAM principal elements by which the support role could be assumed. | `list` | n/a | yes |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| support\_iam\_role | The IAM role used for the support user. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
