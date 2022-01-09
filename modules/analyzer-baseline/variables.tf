variable "analyzer_name" {
  description = "The name for the IAM Access Analyzer resource to be created."
  type        = string
  default     = "default-analyer"
}

variable "is_organization" {
  description = "The boolean flag whether this module is configured for the organization master account or the individual account."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default = {
    "Terraform" = "true"
  }
}
