# iam-baseline

## Features

- Set up IAM Password Policy.
- Create default IAM roles for managing AWS account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allow_users_to_change_password | Whether to allow users to change their own password. | string | `true` | no |
| aws_account_id | The AWS Account ID number of the account. | string | - | yes |
| manager_iam_role_name | The name of the IAM Manager role. | string | `IAM-Manager` | no |
| manager_iam_role_policy_name | The name of the IAM Manager role policy. | string | `IAM-Manager-Policy` | no |
| master_iam_role_name | The name of the IAM Master role. | string | `IAM-Master` | no |
| master_iam_role_policy_name | The name of the IAM Master role policy. | string | `IAM-Master-Policy` | no |
| max_password_age | The number of days that an user password is valid. | string | `90` | no |
| minimum_password_length | Minimum length to require for user passwords. | string | `14` | no |
| password_reuse_prevention | The number of previous passwords that users are prevented from reusing. | string | `24` | no |
| require_lowercase_characters | Whether to require lowercase characters for user passwords. | string | `true` | no |
| require_numbers | Whether to require numbers for user passwords. | string | `true` | no |
| require_symbols | Whether to require symbols for user passwords. | string | `true` | no |
| require_uppercase_characters | Whether to require uppercase characters for user passwords. | string | `true` | no |
| support_iam_role_name | The name of the the support role. | string | `IAM-Support` | no |
| support_iam_role_policy_name | The name of the support role policy. | string | `IAM-Support-Role` | no |
| support_iam_role_principal_arn | The ARN of the IAM principal element by which the support role could be assumed. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| manager_iam_role_arn | The ARN of the IAM role used for the manager user. |
| manager_iam_role_name | The name of the IAM role used for the manager user. |
| master_iam_role_arn | The ARN of the IAM role used for the master user. |
| master_iam_role_name | The name of the IAM role used for the master user. |
| support_iam_role_arn | The ARN of the IAM role used for the support user. |
| support_iam_role_name | The name of the IAM role used for the support user. |
