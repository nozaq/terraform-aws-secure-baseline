# guardduty-baseline

Enable GuardDuty in all regions.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| finding\_publishing\_frequency | Specifies the frequency of notifications sent for subsequent finding occurrences. | string | `"SIX_HOURS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| guardduty\_detector | The GuardDuty detector. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
