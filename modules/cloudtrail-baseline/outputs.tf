output "cloudtrail" {
  description = "The trail for recording events in all regions."
  value       = aws_cloudtrail.global
}

output "kms_key" {
  description = "The  KMS key used for encrypting CloudTrail events."
  value       = aws_kms_key.cloudtrail
}

output "log_delivery_iam_role" {
  description = "The IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = aws_iam_role.cloudwatch_delivery
}

output "log_group" {
  description = "The CloudWatch Logs log group which stores CloudTrail events."
  value       = aws_cloudwatch_log_group.cloudtrail_events
}
