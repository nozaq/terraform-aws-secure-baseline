variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "aws_account_id" {
  description = "The AWS Account ID number of the account."
}

variable "cloudtrail_name" {
  description = "The name of the trail."
  default     = "cloudtrail-multi-region"
}

variable "cloudtrail_sns_topic_enabled" {
  description = "Specifies whether the trail is delivered to a SNS topic."
  default     = true
}

variable "cloudtrail_sns_topic_name" {
  description = "The SNS topic linked to the CloudTrail"
  default     = "cloudtrail-multi-region-sns-topic"
}

variable "cloudwatch_logs_enabled" {
  description = "Specifies whether the trail is delivered to CloudWatch Logs."
  default     = true
}

variable "cloudwatch_logs_group_name" {
  description = "The name of CloudWatch Logs group to which CloudTrail events are delivered."
  default     = "cloudtrail-multi-region"
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  default     = 365
}

variable "iam_role_name" {
  description = "The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  default     = "CloudTrail-CloudWatch-Delivery-Role"
}

variable "iam_role_policy_name" {
  description = "The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  default     = "CloudTrail-CloudWatch-Delivery-Policy"
}

variable "key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  default     = 10
}

variable "region" {
  description = "The AWS region in which CloudTrail is set up."
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket which will store configuration snapshots."
}

variable "s3_key_prefix" {
  description = "The prefix for the specified S3 bucket."
  default     = ""
}

variable "is_organization_trail" {
  description = "Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account."
  default     = false
}

variable "s3_object_level_logging_buckets" {
  description = "The list of S3 bucket ARNs on which to enable object-level logging."
  default     = ["arn:aws:s3:::"] # All S3 buckets
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}

# Use the hack to inject external dependencies from outsite the module.
# See below for more detail.
# https://stackoverflow.com/questions/58275233/terraform-depends-on-with-modules
variable "cloudtrail_depends_on" {
  description = "External resources which should be set up before CloudTrail."
  default     = []
}
