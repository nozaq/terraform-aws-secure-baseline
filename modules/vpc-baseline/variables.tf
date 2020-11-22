variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "enable_flow_logs" {
  description = "The boolean flag whether to enable VPC Flow Logs in the default VPC"
  default     = true
}

variable "flow_logs_destination_type" {
  description = "The type of the logging destination. Valid values: cloud-watch-logs, s3"
  default     = "cloud-watch-logs"
}

# --------------------------------------------------------------------------------------------------
# Variables for CloudWatch Logs logging.
# --------------------------------------------------------------------------------------------------
variable "flow_logs_log_group_name" {
  description = "The name of CloudWatch Logs group to which VPC Flow Logs are delivered if vpc_log_destination_type is cloud-watch-logs."
  default     = ""
}

variable "flow_logs_iam_role_arn" {
  description = "The ARN of the IAM Role which will be used by VPC Flow Logs if vpc_log_destination_type is cloud-watch-logs."
  default     = ""
}

variable "flow_logs_retention_in_days" {
  description = "Number of days to retain logs if vpc_log_destination_type is cloud-watch-logs. CIS recommends 365 days. Possible values are: 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. Set to 0 to keep logs indefinitely."
  default     = 365
}

# --------------------------------------------------------------------------------------------------
# Variables for S3 logging.
# --------------------------------------------------------------------------------------------------
variable "flow_logs_s3_arn" {
  description = "The ARN of the S3 bucket to which VPC Flow Logs are delivered if vpc_log_destination_type is s3."
  default     = ""
}

variable "flow_logs_s3_key_prefix" {
  description = "The prefix used when VPC Flow Logs delivers logs to the S3 bucket."
  default     = "flow-logs"
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}
