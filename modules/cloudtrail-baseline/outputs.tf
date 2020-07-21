output "cloudtrail" {
  description = "The trail for recording events in all regions."
  value       = var.enabled ? aws_cloudtrail.global[0] : null
}

output "cloudtrail_sns_topic" {
  description = "The sns topic linked to the cloudtrail."
  value       = var.cloudtrail_sns_topic_enabled && var.enabled ? aws_sns_topic.cloudtrail-sns-topic[0] : null
}

output "kms_key" {
  description = "The  KMS key used for encrypting CloudTrail events."
  value       = var.enabled ? aws_kms_key.cloudtrail[0] : null
}

output "log_delivery_iam_role" {
  description = "The IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = var.cloudwatch_logs_enabled && var.enabled ? aws_iam_role.cloudwatch_delivery[0] : null
}

output "log_group" {
  description = "The CloudWatch Logs log group which stores CloudTrail events."
  value       = var.cloudwatch_logs_enabled && var.enabled ? aws_cloudwatch_log_group.cloudtrail_events[0] : null
}
