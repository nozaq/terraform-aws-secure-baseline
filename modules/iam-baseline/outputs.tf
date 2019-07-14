output "master_iam_role" {
  description = "The IAM role used for the master user."
  value       = aws_iam_role.master
}

output "manager_iam_role" {
  description = "The IAM role used for the manager user."
  value       = aws_iam_role.manager
}

output "support_iam_role" {
  description = "The IAM role used for the support user."
  value       = aws_iam_role.support
}
