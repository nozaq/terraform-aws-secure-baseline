# guardduty-baseline

Enable GuardDuty in all regions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_guardduty_detector](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/guardduty_detector) |
| [aws_guardduty_invite_accepter](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/guardduty_invite_accepter) |
| [aws_guardduty_member](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/guardduty_member) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| disable\_email\_notification | Boolean whether an email notification is sent to the accounts. | `bool` | `false` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| finding\_publishing\_frequency | Specifies the frequency of notifications sent for subsequent finding occurrences. | `string` | `"SIX_HOURS"` | no |
| invitation\_message | Message for invitation. | `string` | `"This is an automatic invitation message from guardduty-baseline module."` | no |
| master\_account\_id | AWS account ID for master account. | `string` | `""` | no |
| member\_accounts | A list of IDs and emails of AWS accounts which associated as member accounts. | <pre>list(object({<br>    account_id = string<br>    email      = string<br>  }))</pre> | `[]` | no |
| tags | Specifies object tags key and value. This applies to all resources created by this module. | `map` | <pre>{<br>  "Terraform": true<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| guardduty\_detector | The GuardDuty detector. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
