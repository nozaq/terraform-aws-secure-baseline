output "audit_bucket_id" {
  value = "${aws_s3_bucket.audit_log_bucket.id}"
}
