output "alarm_topic_arn" {
  description = "The ARN of the SNS topic to which CloudWatch Alarms will be sent."
  value       = aws_sns_topic.alarms.arn
}
