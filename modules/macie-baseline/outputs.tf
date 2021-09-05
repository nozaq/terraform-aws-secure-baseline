output "aws_macie2_account" {
  description = "Macie Account"
  value       = var.enabled ? aws_macie2_account.default[0] : null
}
