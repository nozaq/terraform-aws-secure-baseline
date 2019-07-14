output "this_bucket" {
  description = "This S3 bucket."
  value       = aws_s3_bucket.content
}

output "log_bucket" {
  description = "The S3 bucket used for storing access logs of this bucket."
  value       = aws_s3_bucket.access_log
}
