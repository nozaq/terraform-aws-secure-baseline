variable "support_iam_role_name" {
  description = "The name of the the support role."
  type        = string
  default     = "IAM-Support"
}

variable "permissions_boundary_arn" {
  description = "The permissions boundary ARN for all IAM Roles, provisioned by this module"
  type        = string
  default     = ""
}

variable "support_iam_role_principal_arns" {
  type        = list(any)
  description = "List of ARNs of the IAM principal elements by which the support role could be assumed."
}

variable "max_password_age" {
  description = "The number of days that an user password is valid."
  type        = number
  default     = 0
}

variable "minimum_password_length" {
  description = "Minimum length to require for user passwords."
  type        = number
  default     = 14
}

variable "password_reuse_prevention" {
  description = "The number of previous passwords that users are prevented from reusing."
  type        = number
  default     = 24
}

variable "require_lowercase_characters" {
  description = "Whether to require lowercase characters for user passwords."
  type        = bool
  default     = true
}

variable "require_numbers" {
  description = "Whether to require numbers for user passwords."
  type        = bool
  default     = true
}

variable "require_uppercase_characters" {
  description = "Whether to require uppercase characters for user passwords."
  type        = bool
  default     = true
}

variable "require_symbols" {
  description = "Whether to require symbols for user passwords."
  type        = bool
  default     = true
}

variable "allow_users_to_change_password" {
  description = "Whether to allow users to change their own password."
  type        = bool
  default     = true
}

variable "create_password_policy" {
  description = "Define if the password policy should be created."
  type        = bool
  default     = true
}

variable "create_support_role" {
  description = "Define if the support role should be created."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default = {
    "Terraform" = "true"
  }
}

