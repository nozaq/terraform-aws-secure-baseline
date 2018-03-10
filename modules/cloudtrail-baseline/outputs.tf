output "cloudtrail_id" {
  description = "The ID of the trail for recording events in all regions."
  value       = "${aws_cloudtrail.global.id}"
}

output "cloudtrail_arn" {
  description = "The ARN of the trail for recording events in all regions."
  value       = "${aws_cloudtrail.global.arn}"
}

output "kms_key_arn" {
  description = "The ARN of the KMS key used for encrypting CloudTrail events."
  value       = "${aws_kms_key.cloudtrail.arn}"
}

output "kms_key_id" {
  description = "The ID of the KMS key used for encrypting CloudTrail events."
  value       = "${aws_kms_key.cloudtrail.key_id}"
}

output "log_delivery_iam_role_arn" {
  description = "The ARN of the IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = "${aws_iam_role.cloudwatch_delivery.arn}"
}

output "log_delivery_iam_role_name" {
  description = "The name of the IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = "${aws_iam_role.cloudwatch_delivery.name}"
}

output "log_group_arn" {
  description = "The ARN of the CloudWatch Logs log group which stores CloudTrail events."
  value       = "${aws_cloudwatch_log_group.cloudtrail_events.arn}"
}

output "log_group_name" {
  description = "The name of the CloudWatch Logs log group which stores CloudTrail events."
  value       = "${aws_cloudwatch_log_group.cloudtrail_events.name}"
}
