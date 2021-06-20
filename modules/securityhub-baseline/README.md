# securityhub-baseline

## Features

- Enable SecurityHub.
- Subscribe CIS benchmark standard.
- Subscribe PCI DSS standard.
- Subscribe AWS Foundational security best practices standard.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

| Name                                                                     | Version   |
| ------------------------------------------------------------------------ | --------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13   |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 3.50.0 |

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | 3.60.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                      | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_securityhub_account.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account)                                           | resource    |
| [aws_securityhub_member.members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_member)                                          | resource    |
| [aws_securityhub_product_subscription.products](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_product_subscription)             | resource    |
| [aws_securityhub_standards_subscription.aws_foundational](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource    |
| [aws_securityhub_standards_subscription.cis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription)              | resource    |
| [aws_securityhub_standards_subscription.pci_dss](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription)          | resource    |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                                               | data source |

## Inputs

| Name                                                                                                                              | Description                                                                                                                                                               | Type                                                                        | Default | Required |
| --------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_enable_aws_foundational_standard"></a> [enable_aws_foundational_standard](#input_enable_aws_foundational_standard) | Boolean whether AWS Foundations standard is enabled.                                                                                                                      | `bool`                                                                      | `true`  |    no    |
| <a name="input_enable_cis_standard"></a> [enable_cis_standard](#input_enable_cis_standard)                                        | Boolean whether CIS standard is enabled.                                                                                                                                  | `bool`                                                                      | `true`  |    no    |
| <a name="input_enable_pci_dss_standard"></a> [enable_pci_dss_standard](#input_enable_pci_dss_standard)                            | Boolean whether PCI DSS standard is enabled.                                                                                                                              | `bool`                                                                      | `true`  |    no    |
| <a name="input_enable_product_arns"></a> [enable_product_arns](#input_enable_product_arns)                                        | List of Security Hub product ARNs, `<REGION>` will be replaced. See https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-partner-providers.html for list. | `list(string)`                                                              | `[]`    |    no    |
| <a name="input_enabled"></a> [enabled](#input_enabled)                                                                            | The boolean flag whether this module is enabled or not. No resources are created when set to false.                                                                       | `bool`                                                                      | `true`  |    no    |
| <a name="input_member_accounts"></a> [member_accounts](#input_member_accounts)                                                    | A list of IDs and emails of AWS accounts which associated as member accounts.                                                                                             | <pre>list(object({<br> account_id = string<br> email = string<br> }))</pre> | `[]`    |    no    |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
