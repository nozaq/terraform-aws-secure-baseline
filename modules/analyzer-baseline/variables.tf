variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "analyzer_name" {
  description = "The name for the IAM Access Analyzer resource to be created."
  default     = "default-analyer"
}

variable "is_organization" {
  description = "The boolean flag whether this module is configured for the organization master account or the individual account."
  default     = false
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}
