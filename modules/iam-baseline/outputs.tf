output "support_iam_role" {
  description = "The IAM role used for the support user."
  value       = aws_iam_role.support
}
