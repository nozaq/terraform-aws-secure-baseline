resource "aws_s3_bucket" "access_log" {
  bucket = "${var.log_bucket_name}"

  acl = "log-delivery-write"

  lifecycle_rule {
    id      = "auto-archive"
    enabled = true

    prefix = "/"

    transition {
      days          = "${var.lifecycle_glacier_transition_days}"
      storage_class = "GLACIER"
    }
  }
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

  lifecycle_rule {
    id      = "auto-archive"
    enabled = true

    prefix = "/"

    transition {
      days          = "${var.lifecycle_glacier_transition_days}"
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = "${var.lifecycle_glacier_transition_days}"
      storage_class = "GLACIER"
    }
  }
}
