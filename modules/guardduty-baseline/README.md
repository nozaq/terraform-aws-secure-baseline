# guardduty-baseline

Enable GuardDuty in all regions.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| finding_publishing_frequency | Specifies the frequency of notifications sent for subsequent finding occurrences. | string | `SIX_HOURS` | no |

## Outputs

| Name | Description |
|------|-------------|
| guardduty_detector | The GuardDuty detector. |
