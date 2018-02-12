output "bucket_id" {
  value = "${aws_s3_bucket.content.id}"
}

output "bucket_arn" {
  value = "${aws_s3_bucket.content.arn}"
}

output "log_bucket_id" {
  value = "${aws_s3_bucket.access_log.id}"
}

output "log_bucket_arn" {
  value = "${aws_s3_bucket.access_log.arn}"
}
