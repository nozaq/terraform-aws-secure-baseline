# --------------------------------------------------------------------------------------------------
# Variables for root module.
# --------------------------------------------------------------------------------------------------

variable "aws_account_id" {
  description = "The AWS Account ID number of the account."
}

variable "audit_log_bucket_name" {
  description = "The name of the S3 bucket to store various audit logs."
}

variable "audit_log_lifecycle_glacier_transition_days" {
  description = "The number of days after log creation when the log file is archived into Glacier."
  default     = 90
}

variable "region" {
  description = "The AWS region in which global resources are set up."
}

# --------------------------------------------------------------------------------------------------
# Variables for iam-baseline module.
# --------------------------------------------------------------------------------------------------

variable "master_iam_role_name" {
  description = "The name of the IAM Master role."
  default     = "IAM-Master"
}

variable "master_iam_role_policy_name" {
  description = "The name of the IAM Master role policy."
  default     = "IAM-Master-Policy"
}

variable "manager_iam_role_name" {
  description = "The name of the IAM Manager role."
  default     = "IAM-Manager"
}

variable "manager_iam_role_policy_name" {
  description = "The name of the IAM Manager role policy."
  default     = "IAM-Manager-Policy"
}

variable "support_iam_role_name" {
  description = "The name of the the support role."
  default     = "IAM-Support"
}

variable "support_iam_role_policy_name" {
  description = "The name of the support role policy."
  default     = "IAM-Support-Role"
}

variable "support_iam_role_principal_arn" {
  description = "The ARN of the IAM principal element by which the support role could be assumed."
}

variable "max_password_age" {
  description = "The number of days that an user password is valid."
  default     = 90
}

variable "minimum_password_length" {
  description = "Minimum length to require for user passwords."
  default     = 14
}

variable "password_reuse_prevention" {
  description = "The number of previous passwords that users are prevented from reusing."
  default     = 24
}

variable "require_lowercase_characters" {
  description = "Whether to require lowercase characters for user passwords."
  default     = true
}

variable "require_numbers" {
  description = "Whether to require numbers for user passwords."
  default     = true
}

variable "require_uppercase_characters" {
  description = "Whether to require uppercase characters for user passwords."
  default     = true
}

variable "require_symbols" {
  description = "Whether to require symbols for user passwords."
  default     = true
}

variable "allow_users_to_change_password" {
  description = "Whether to allow users to change their own password."
  default     = true
}

# --------------------------------------------------------------------------------------------------
# Variables for vpc-baseline module.
# --------------------------------------------------------------------------------------------------
variable "vpc_iam_role_name" {
  description = "The name of the IAM Role which VPC Flow Logs will use."
  default     = "VPC-Flow-Logs-Publisher"
}

variable "vpc_iam_role_policy_name" {
  description = "The name of the IAM Role Policy which VPC Flow Logs will use."
  default     = "VPC-Flow-Logs-Publish-Policy"
}

variable "vpc_log_group_name" {
  description = "The name of CloudWatch Logs group to which VPC Flow Logs are delivered."
  default     = "default-vpc-flow-logs"
}

variable "vpc_log_retention_in_days" {
  description = "Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  default     = 365
}

# --------------------------------------------------------------------------------------------------
# Variables for config-baseline module.
# --------------------------------------------------------------------------------------------------

variable "config_delivery_frequency" {
  description = "The frequency which AWS Config sends a snapshot into the S3 bucket."
  default     = "One_Hour"
}

variable "config_iam_role_name" {
  description = "The name of the IAM Role which AWS Config will use."
  default     = "Config-Recorder"
}

variable "config_iam_role_policy_name" {
  description = "The name of the IAM Role Policy which AWS Config will use."
  default     = "Config-Recorder-Policy"
}

variable "config_s3_bucket_key_prefix" {
  description = "The prefix used when writing AWS Config snapshots into the S3 bucket."
  default     = "config"
}

variable "config_sns_topic_name" {
  description = "The name of the SNS Topic to be used to notify configuration changes."
  default     = "ConfigChanges"
}

# --------------------------------------------------------------------------------------------------
# Variables for cloudtrail-baseline module.
# --------------------------------------------------------------------------------------------------

variable "cloudtrail_cloudwatch_logs_group_name" {
  description = "The name of CloudWatch Logs group to which CloudTrail events are delivered."
  default     = "cloudtrail-multi-region"
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Number of days to retain logs for. CIS recommends 365 days.  Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  default     = 365
}

variable "cloudtrail_iam_role_name" {
  description = "The name of the IAM Role to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  default     = "CloudTrail-CloudWatch-Delivery-Role"
}

variable "cloudtrail_iam_role_policy_name" {
  description = "The name of the IAM Role Policy to be used by CloudTrail to delivery logs to CloudWatch Logs group."
  default     = "CloudTrail-CloudWatch-Delivery-Policy"
}

variable "cloudtrail_key_deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction of the resource, must be between 7 and 30 days. Defaults to 30 days."
  default     = 10
}

variable "cloudtrail_name" {
  description = "The name of the trail."
  default     = "cloudtrail-multi-region"
}

variable "cloudtrail_s3_key_prefix" {
  description = "The prefix used when CloudTrail delivers events to the S3 bucket."
  default     = "cloudtrail"
}

# --------------------------------------------------------------------------------------------------
# Variables for alarm-baseline module.
# --------------------------------------------------------------------------------------------------

variable "alarm_namespace" {
  description = "The namespace in which all alarms are set up."
  default     = "CISBenchmark"
}

variable "alarm_sns_topic_name" {
  description = "The name of the SNS Topic which will be notified when any alarm is performed."
  default     = "CISAlarm"
}
