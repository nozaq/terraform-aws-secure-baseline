variable "aggregate_findings" {
  description = "Boolean whether to enable finding aggregator for every region"
  default     = false
}

variable "enable_cis_standard" {
  description = "Boolean whether CIS standard is enabled."
  default     = true
}

variable "enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled."
  default     = true
}

variable "enable_aws_foundational_standard" {
  description = "Boolean whether AWS Foundations standard is enabled."
  default     = true
}

variable "enable_product_arns" {
  description = "List of Security Hub product ARNs, `<REGION>` will be replaced. See https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-partner-providers.html for list."
  type        = list(string)
  default     = []
}

variable "member_accounts" {
  description = "A list of IDs and emails of AWS accounts which associated as member accounts."
  type = list(object({
    account_id = string
    email      = string
  }))
  default = []
}
