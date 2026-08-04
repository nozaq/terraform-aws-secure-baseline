output "this_bucket" {
  description = "This S3 bucket."
  value       = aws_s3_bucket.content
}

output "log_bucket" {
  description = "The S3 bucket used for storing access logs of this bucket."
  value       = aws_s3_bucket.access_log
}

output "log_bucket_policy" {
  description = "Bucket policy to use on the bucket for the access logs."
  value       = data.aws_iam_policy_document.access_log_policy
}
