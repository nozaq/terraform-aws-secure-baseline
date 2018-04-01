resource "aws_s3_bucket" "access_log" {
  bucket = "${var.log_bucket_name}"

  acl = "log-delivery-write"
}

resource "aws_s3_bucket" "content" {
  bucket = "${var.bucket_name}"

  acl = "private"

  logging = {
    target_bucket = "${aws_s3_bucket.access_log.id}"
  }

  versioning = {
    enabled    = true
    mfa_delete = true
  }
}
