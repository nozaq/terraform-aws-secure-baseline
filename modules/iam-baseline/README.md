# iam-baseline

## Features

- Set up IAM Password Policy.
- Create default IAM roles for managing AWS account.

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
| <a name="input_support_iam_role_principal_arns"></a> [support\_iam\_role\_principal\_arns](#input\_support\_iam\_role\_principal\_arns) | List of ARNs of the IAM principal elements by which the support role could be assumed. | `list(any)` | yes |
| <a name="input_allow_users_to_change_password"></a> [allow\_users\_to\_change\_password](#input\_allow\_users\_to\_change\_password) | Whether to allow users to change their own password. | `bool` | no |
| <a name="input_create_password_policy"></a> [create\_password\_policy](#input\_create\_password\_policy) | Define if the password policy should be created. | `bool` | no |
| <a name="input_create_support_role"></a> [create\_support\_role](#input\_create\_support\_role) | Define if the support role should be created. | `bool` | no |
| <a name="input_max_password_age"></a> [max\_password\_age](#input\_max\_password\_age) | The number of days that an user password is valid. | `number` | no |
| <a name="input_minimum_password_length"></a> [minimum\_password\_length](#input\_minimum\_password\_length) | Minimum length to require for user passwords. | `number` | no |
| <a name="input_password_reuse_prevention"></a> [password\_reuse\_prevention](#input\_password\_reuse\_prevention) | The number of previous passwords that users are prevented from reusing. | `number` | no |
| <a name="input_permissions_boundary_arn"></a> [permissions\_boundary\_arn](#input\_permissions\_boundary\_arn) | The permissions boundary ARN for all IAM Roles, provisioned by this module | `string` | no |
| <a name="input_require_lowercase_characters"></a> [require\_lowercase\_characters](#input\_require\_lowercase\_characters) | Whether to require lowercase characters for user passwords. | `bool` | no |
| <a name="input_require_numbers"></a> [require\_numbers](#input\_require\_numbers) | Whether to require numbers for user passwords. | `bool` | no |
| <a name="input_require_symbols"></a> [require\_symbols](#input\_require\_symbols) | Whether to require symbols for user passwords. | `bool` | no |
| <a name="input_require_uppercase_characters"></a> [require\_uppercase\_characters](#input\_require\_uppercase\_characters) | Whether to require uppercase characters for user passwords. | `bool` | no |
| <a name="input_support_iam_role_name"></a> [support\_iam\_role\_name](#input\_support\_iam\_role\_name) | The name of the the support role. | `string` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map(string)` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_support_iam_role"></a> [support\_iam\_role](#output\_support\_iam\_role) | The IAM role used for the support user. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
