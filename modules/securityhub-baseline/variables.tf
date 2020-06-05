variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "securityhub_enable_cis_standard" {
  description = "Boolean whether CIS standard is enabled."
  default     = true
}

variable "securityhub_enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled."
  default     = true
}

variable "securityhub_enable_aws_foundational_standard" {
  description = "Boolean whether AWS Foundations standard is enabled."
  default     = true
}
