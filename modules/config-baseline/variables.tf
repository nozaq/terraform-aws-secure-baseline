variable "iam_role_arn" {
  description = "The ARN of the IAM Role which AWS Config will use."
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket which will store configuration snapshots."
  type        = string
}

variable "s3_key_prefix" {
  description = "The prefix for the specified S3 bucket."
  type        = string
  default     = ""
}

variable "sns_topic_name" {
  description = "The name of the SNS Topic to be used to notify configuration changes."
  type        = string
  default     = "ConfigChanges"
}

variable "sns_topic_kms_master_key_id" {
  description = "To enable SNS Topic encryption enter value with the ID of a custom master KMS key that is used for encryption"
  type        = string
  default     = null
}

variable "delivery_frequency" {
  description = "The frequency which AWS Config sends a snapshot into the S3 bucket."
  type        = string
  default     = "One_Hour"
}

variable "recorder_name" {
  description = "The name of the configuration recorder."
  type        = string
  default     = "default"
}

variable "delivery_channel_name" {
  description = "The name of the delivery channel."
  type        = string
  default     = "default"
}

variable "include_global_resource_types" {
  description = "Specifies whether AWS Config includes all supported types of global resources with the resources that it records."
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
