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
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/data-sources/region) |
| [aws_securityhub_account](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/securityhub_account) |
| [aws_securityhub_member](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/securityhub_member) |
| [aws_securityhub_standards_subscription](https://registry.terraform.io/providers/hashicorp/aws/3.0.0/docs/resources/securityhub_standards_subscription) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable\_aws\_foundational\_standard | Boolean whether AWS Foundations standard is enabled. | `bool` | `true` | no |
| enable\_cis\_standard | Boolean whether CIS standard is enabled. | `bool` | `true` | no |
| enable\_pci\_dss\_standard | Boolean whether PCI DSS standard is enabled. | `bool` | `true` | no |
| enabled | The boolean flag whether this module is enabled or not. No resources are created when set to false. | `bool` | `true` | no |
| member\_accounts | A list of IDs and emails of AWS accounts which associated as member accounts. | <pre>list(object({<br>    account_id = string<br>    email      = string<br>  }))</pre> | `[]` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
