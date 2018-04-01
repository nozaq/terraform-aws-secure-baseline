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
    enabled = true

    # Temporarily disabled due to Terraform issue.
    # https://github.com/terraform-providers/terraform-provider-aws/issues/629
    # mfa_delete = true
  }
}
