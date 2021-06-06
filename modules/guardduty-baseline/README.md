# guardduty-baseline

Enable GuardDuty in all regions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_guardduty_detector.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_guardduty_invite_accepter.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_invite_accepter) | resource |
| [aws_guardduty_member.members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disable_email_notification"></a> [disable\_email\_notification](#input\_disable\_email\_notification) | Boolean whether an email notification is sent to the accounts. | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| <a name="input_finding_publishing_frequency"></a> [finding\_publishing\_frequency](#input\_finding\_publishing\_frequency) | Specifies the frequency of notifications sent for subsequent finding occurrences. | `string` | `"SIX_HOURS"` | no |
| <a name="input_invitation_message"></a> [invitation\_message](#input\_invitation\_message) | Message for invitation. | `string` | `"This is an automatic invitation message from guardduty-baseline module."` | no |
| <a name="input_master_account_id"></a> [master\_account\_id](#input\_master\_account\_id) | AWS account ID for master account. | `string` | `""` | no |
| <a name="input_member_accounts"></a> [member\_accounts](#input\_member\_accounts) | A list of IDs and emails of AWS accounts which associated as member accounts. | <pre>list(object({<br>    account_id = string<br>    email      = string<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_guardduty_detector"></a> [guardduty\_detector](#output\_guardduty\_detector) | The GuardDuty detector. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
