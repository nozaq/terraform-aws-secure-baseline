variable "finding_publishing_frequency" {
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences."
  default     = "SIX_HOURS"
}

variable "member_accounts" {
  description = "A list of IDs and emails of AWS accounts which associated as member accounts."
  type = list(object({
    account_id = string
    email      = string
  }))
  default = []
}

variable "invitation_message" {
  description = "Message for invitation."
  default     = "This is an automatic invitation message from guardduty-baseline module."
}

variable "master_account_id" {
  description = "AWS account ID for master account."
  default     = ""
}
