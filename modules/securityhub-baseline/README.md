# securityhub-baseline

## Features

- Enable SecurityHub.
- Subscribe CIS benchmark standard.
- Subscribe PCI DSS standard.
- Subscribe AWS Foundational security best practices standard.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.3 |

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="input_aggregate_findings"></a> [aggregate\_findings](#input\_aggregate\_findings) | Boolean whether to enable finding aggregator for every region | `bool` | no |
| <a name="input_enable_aws_foundational_standard"></a> [enable\_aws\_foundational\_standard](#input\_enable\_aws\_foundational\_standard) | Boolean whether AWS Foundations standard is enabled. | `bool` | no |
| <a name="input_enable_cis_standard"></a> [enable\_cis\_standard](#input\_enable\_cis\_standard) | Boolean whether CIS standard is enabled. | `bool` | no |
| <a name="input_enable_pci_dss_standard"></a> [enable\_pci\_dss\_standard](#input\_enable\_pci\_dss\_standard) | Boolean whether PCI DSS standard is enabled. | `bool` | no |
| <a name="input_enable_product_arns"></a> [enable\_product\_arns](#input\_enable\_product\_arns) | List of Security Hub product ARNs, `<REGION>` will be replaced. See https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-partner-providers.html for list. | `list(string)` | no |
| <a name="input_master_account_id"></a> [master\_account\_id](#input\_master\_account\_id) | AWS account ID for master account. | `string` | no |
| <a name="input_member_accounts"></a> [member\_accounts](#input\_member\_accounts) | A list of IDs and emails of AWS accounts which associated as member accounts. | <pre>list(object({<br>    account_id = string<br>    email      = string<br>  }))</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
