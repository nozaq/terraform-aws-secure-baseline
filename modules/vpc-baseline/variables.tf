variable "vpc_flow_logs_group_arn" {
  description = "The arn of the CloudWatch Logs group to which VPC Flow Logs will be written."
}

variable "vpc_flow_logs_iam_role_arn" {
  description = "The ARN of the IAM Role which will be used by VPC Flow Logs."
}
