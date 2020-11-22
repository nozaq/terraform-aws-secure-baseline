# --------------------------------------------------------------------------------------------------
# Variables for root module.
# --------------------------------------------------------------------------------------------------

variable "aws_account_id" {
  description = "The AWS Account ID number of the account."
}

variable "region" {
  description = "The AWS region in which global resources are set up."
}

variable "account_type" {
  description = "The type of the AWS account. The possible values are `individual`, `master` and `member` . Specify `master` and `member` to set up centalized logging for multiple accounts in AWS Organization. Use individual` otherwise."
  default     = "individual"
}

variable "master_account_id" {
  description = "The ID of the master AWS account to which the current AWS account is associated. Required if `account_type` is `member`."
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

variable "target_regions" {
  description = "A list of regions to set up with this module."
  default = [
    "ap-northeast-1",
    "ap-northeast-2",
    "ap-south-1",
    "ap-southeast-1",
    "ap-southeast-2",
    "ca-central-1",
    "eu-central-1",
    "eu-north-1",
    "eu-west-1",
    "eu-west-2",
    "eu-west-3",
    "sa-east-1",
    "us-east-1",
    "us-east-2",
    "us-west-1",
    "us-west-2"
  ]
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
  }
}

# --------------------------------------------------------------------------------------------------
# Variables for audit log bucket configurations.
# --------------------------------------------------------------------------------------------------
variable "audit_log_bucket_name" {
  description = "The name of the S3 bucket to store various audit logs."
}

variable "audit_log_bucket_custom_policy_json" {
  description = "Override policy for the audit log bucket. Allows addition of extra policies."
  default     = "{}"
}

variable "audit_log_lifecycle_glacier_transition_days" {
  description = "The number of days after log creation when the log file is archived into Glacier."
  default     = 90
}

variable "audit_log_bucket_force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the audit log bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
}

variable "use_external_audit_log_bucket" {
  description = "A boolean that indicates whether the specific audit log bucket already exists. Create a new S3 bucket if it is set to false."
  default     = false
}

# --------------------------------------------------------------------------------------------------
# Variables for iam-baseline module.
# --------------------------------------------------------------------------------------------------
variable "create_password_policy" {
  type        = bool
  description = "Define if the password policy should be created."
  default     = true
}

variable "create_master_role" {
  type        = bool
  description = "Define if the master role should be created."
  default     = true
}

variable "create_manager_role" {
  type        = bool
  description = "Define if the manager role should be created."
  default     = true
}

variable "create_support_role" {
  type        = bool
  description = "Define if the support role should be created."
  default     = true
}

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

variable "support_iam_role_principal_arns" {
  type        = list
  description = "List of ARNs of the IAM principal elements by which the support role could be assumed."
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

variable "vpc_enable_flow_logs" {
  description = "The boolean flag whether to enable VPC Flow Logs in default VPCs"
  default     = true
}

variable "vpc_flow_logs_destination_type" {
  description = "The type of the logging destination. Valid values: cloud-watch-logs, s3"
  default     = "cloud-watch-logs"
}

variable "vpc_flow_logs_log_group_name" {
  description = "The name of CloudWatch Logs group to which VPC Flow Logs are delivered."
  default     = "default-vpc-flow-logs"
}

variable "vpc_flow_logs_retention_in_days" {
  description = "Number of days to retain logs if vpc_log_destination_type is cloud-watch-logs. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  default     = 365
}

variable "vpc_flow_logs_s3_arn" {
  description = "ARN of the S3 bucket to which VPC Flow Logs are delivered if vpc_log_destination_type is s3."
  default     = ""
}

variable "vpc_flow_logs_s3_key_prefix" {
  description = "The prefix used when VPC Flow Logs delivers logs to the S3 bucket."
  default     = "flow-logs"
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

variable "config_aggregator_name" {
  description = "The name of the organizational AWS Config Configuration Aggregator."
  default     = "organization-aggregator"
}

variable "config_aggregator_name_prefix" {
  description = "The prefix of the name for the IAM role attached to the organizational AWS Config Configuration Aggregator."
  default     = "config-for-organization-role"
}

# --------------------------------------------------------------------------------------------------
# Variables for cloudtrail-baseline module.
# --------------------------------------------------------------------------------------------------

variable "cloudtrail_cloudwatch_logs_enabled" {
  description = "Specifies whether the trail is delivered to CloudWatch Logs."
  default     = true
}

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

variable "cloudtrail_sns_topic_enabled" {
  description = "Specifies whether the trail is delivered to a SNS topic."
  default     = true
}

variable "cloudtrail_sns_topic_name" {
  description = "The name of the SNS topic to link to the trail."
  default     = "cloudtrail-multi-region-sns-topic"
}

variable "cloudtrail_s3_key_prefix" {
  description = "The prefix used when CloudTrail delivers events to the S3 bucket."
  default     = "cloudtrail"
}

variable "cloudtrail_s3_object_level_logging_buckets" {
  description = "The list of S3 bucket ARNs on which to enable object-level logging."
  default     = ["arn:aws:s3:::"] # All S3 buckets
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

# --------------------------------------------------------------------------------------------------
# Variables for guardduty-baseline module.
# --------------------------------------------------------------------------------------------------
variable "guardduty_disable_email_notification" {
  description = "Boolean whether an email notification is sent to the accounts."
  default     = false
}

variable "guardduty_finding_publishing_frequency" {
  description = "Specifies the frequency of notifications sent for subsequent finding occurrences."
  default     = "SIX_HOURS"
}

variable "guardduty_invitation_message" {
  description = "Message for invitation."
  default     = "This is an automatic invitation message from guardduty-baseline module."
}

# --------------------------------------------------------------------------------------------------
# Variables for securityhub-baseline module.
# --------------------------------------------------------------------------------------------------
variable "securityhub_enable_cis_standard" {
  description = "Boolean whether CIS standard is enabled."
  default     = true
}

variable "securityhub_enable_pci_dss_standard" {
  description = "Boolean whether PCI DSS standard is enabled."
  default     = false
}

variable "securityhub_enable_aws_foundational_standard" {
  description = "Boolean whether AWS Foundations standard is enabled."
  default     = true
}

# --------------------------------------------------------------------------------------------------
# Variables for analyzer-baseline module.
# --------------------------------------------------------------------------------------------------
variable "analyzer_name" {
  description = "The name for the IAM Access Analyzer resource to be created."
  default     = "default-analyer"
}
