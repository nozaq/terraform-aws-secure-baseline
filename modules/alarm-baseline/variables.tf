variable "enabled" {
  description = "The boolean flag whether this module is enabled or not. No resources are created when set to false."
  default     = true
}

variable "alarm_namespace" {
  description = "The namespace in which all alarms are set up."
  default     = "CISBenchmark"
}

variable "cloudtrail_log_group_name" {
  description = "The name of the CloudWatch Logs group to which CloudTrail events are delivered."
}

variable "sns_topic_name" {
  description = "The name of the SNS Topic which will be notified when any alarm is performed."
  default     = "CISAlarm"
}

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}
