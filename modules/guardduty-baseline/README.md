# guardduty-baseline

Enable GuardDuty in all regions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| finding\_publishing\_frequency | Specifies the frequency of notifications sent for subsequent finding occurrences. | string | `"SIX_HOURS"` | no |
| invitation\_message | Message for invitation. | string | `"This is an automatic invitation message from guardduty-baseline module."` | no |
| master\_account\_id | AWS account ID for master account. | string | `""` | no |
| member\_accounts | A list of IDs and emails of AWS accounts which associated as member accounts. | object | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| guardduty\_detector | The GuardDuty detector. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
