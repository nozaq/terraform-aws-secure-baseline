output "this_bucket_arn" {
  description = "The ARN of this S3 bucket."
  value       = aws_s3_bucket.content.arn
}

output "this_bucket_id" {
  description = "The ID of this S3 bucket."
  value       = aws_s3_bucket.content.id
}

output "log_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing access logs of this bucket."
  value       = aws_s3_bucket.access_log.arn
}

output "log_bucket_id" {
  description = "The ID of the S3 bucket used for storing access logs of this bucket."
  value       = aws_s3_bucket.access_log.id
}
