output "this_bucket" {
  description = "This S3 bucket."
  value       = var.enabled ? aws_s3_bucket.content[0] : null
}

output "log_bucket" {
  description = "The S3 bucket used for storing access logs of this bucket."
  value       = var.enabled ? aws_s3_bucket.access_log[0] : null
}
