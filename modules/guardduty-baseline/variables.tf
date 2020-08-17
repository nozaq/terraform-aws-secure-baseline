variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "disable_email_notification" {
  description = "Boolean whether an email notification is sent to the accounts."
  default     = false
}

variable "finding_publishing_frequency" {
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences."
  default     = "SIX_HOURS"
}

variable "invitation_message" {
  description = "Message for invitation."
  default     = "This is an automatic invitation message from guardduty-baseline module."
}

variable "master_account_id" {
  description = "AWS account ID for master account."
  default     = ""
}

variable "member_accounts" {
  description = "A list of IDs and emails of AWS accounts which associated as member accounts."
  type = list(object({
    account_id = string
    email      = string
  }))
  default = []
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}
