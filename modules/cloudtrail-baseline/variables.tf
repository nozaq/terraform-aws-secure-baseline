variable "aws_account_id" {
  description = "The AWS Account ID number of the account."
  type        = string
}

variable "cloudtrail_name" {
  description = "The name of the trail."
  type        = string
  default     = "cloudtrail-multi-region"
}

variable "cloudtrail_sns_topic_enabled" {
  description = "Specifies whether the trail is delivered to a SNS topic."
  type        = bool
  default     = true
}

variable "cloudtrail_sns_topic_name" {
  description = "The SNS topic linked to the CloudTrail"
  type        = string
  default     = "cloudtrail-multi-region-sns-topic"
}

variable "cloudwatch_logs_enabled" {
  description = "Specifies whether the trail is delivered to CloudWatch Logs."
  type        = bool
  default     = true
}

variable "cloudwatch_logs_group_name" {
  description = "The name of CloudWatch Logs group to which CloudTrail events are delivered."
  type        = string
  default     = "cloudtrail-multi-region"
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  type        = number
  default     = 365
}

variable "iam_role_name" {
  description = "The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  type        = string
  default     = "CloudTrail-CloudWatch-Delivery-Role"
}

variable "iam_role_policy_name" {
  description = "The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  type        = string
  default     = "CloudTrail-CloudWatch-Delivery-Policy"
}

variable "permissions_boundary_arn" {
  description = "The permissions boundary ARN for all IAM Roles, provisioned by this module"
  type        = string
  default     = ""
}

variable "key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  type        = number
  default     = 10
}

variable "region" {
  description = "The AWS region in which CloudTrail is set up."
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

variable "is_organization_trail" {
  description = "Specifies whether the trail is an AWS Organizations trail. Organization trails log events for the master account and all member accounts. Can only be created in the organization master account."
  type        = bool
  default     = false
}

variable "s3_object_level_logging_buckets" {
  description = "The list of S3 bucket ARNs on which to enable object-level logging."
  type        = list(string)
  default     = ["arn:aws:s3:::"] # All S3 buckets
}

variable "dynamodb_event_logging_tables" {
  description = "The list of DynamoDB table ARNs on which to enable event logging."
  type        = list(string)
  default     = ["arn:aws:dynamodb"] # All DynamoDB tables
}

variable "lambda_invocation_logging_lambdas" {
  description = "The list of lambda ARNs on which to enable invocation logging."
  type        = list(string)
  default     = ["arn:aws:lambda"] # All lambdas
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  type        = map(string)
  default = {
    "Terraform" = "true"
  }
}

# Use the hack to inject external dependencies from outsite the module.
# See below for more detail.
# https://stackoverflow.com/questions/58275233/terraform-depends-on-with-modules
variable "cloudtrail_depends_on" {
  description = "External resources which should be set up before CloudTrail."
  type        = list(any)
  default     = []
}
