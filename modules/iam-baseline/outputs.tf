output "master_iam_role_arn" {
  description = "The ARN of the IAM role used for the master user."
  value       = aws_iam_role.master.arn
}

output "master_iam_role_name" {
  description = "The name of the IAM role used for the master user."
  value       = aws_iam_role.master.name
}

output "manager_iam_role_arn" {
  description = "The ARN of the IAM role used for the manager user."
  value       = aws_iam_role.manager.arn
}

output "manager_iam_role_name" {
  description = "The name of the IAM role used for the manager user."
  value       = aws_iam_role.manager.name
}

output "support_iam_role_arn" {
  description = "The ARN of the IAM role used for the support user."
  value       = aws_iam_role.support.arn
}

output "support_iam_role_name" {
  description = "The name of the IAM role used for the support user."
  value       = aws_iam_role.support.name
}
