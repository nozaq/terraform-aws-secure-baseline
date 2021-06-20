output "configuration_recorder" {
  description = "The configuration recorder."
  value       = aws_config_configuration_recorder.recorder
}

output "config_sns_topic" {
  description = "The SNS topic that AWS Config delivers notifications to."
  value       = aws_sns_topic.config
}
