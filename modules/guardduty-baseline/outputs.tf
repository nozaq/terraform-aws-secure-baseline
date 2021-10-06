output "guardduty_detector" {
  description = "The GuardDuty detector."
  value       = var.enabled ? try(aws_guardduty_detector.default[0], data.aws_guardduty_detector.default[0]) : null
}
