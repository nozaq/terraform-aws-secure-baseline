variable "iam_role_arn" {
  description = "The ARN of the IAM Role which AWS Config will use."
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket which will store configuration snapshots."
}

variable "s3_key_prefix" {
  description = "The prefix for the specified S3 bucket."
  default     = ""
}

variable "sns_topic_name" {
  description = "The name of the SNS Topic to be used to notify configuration changes."
  default     = "ConfigChanges"
}

variable "delivery_frequency" {
  description = "The frequency which AWS Config sends a snapshot into the S3 bucket."
  default     = "One_Hour"
}

variable "recorder_name" {
  description = "The name of the configuration recorder."
  default     = "default"
}

variable "delivery_channel_name" {
  description = "The name of the delivery channel."
  default     = "default"
}
