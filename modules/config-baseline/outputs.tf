output "configuration_recorder_id" {
  description = "The name of the configuration recorder."
  value       = aws_config_configuration_recorder.recorder.id
}

output "config_topic_arn" {
  description = "The ARN of the SNS topic that AWS Config delivers notifications to."
  value       = aws_sns_topic.config.arn
}
