data "aws_iam_policy_document" "access_log_policy" {
  count = var.enabled ? 1 : 0

  statement {
    actions = ["s3:*"]
    effect  = "Deny"
    resources = [
      aws_s3_bucket.access_log[0].arn,
      "${aws_s3_bucket.access_log[0].arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket" "access_log" {
  count = var.enabled ? 1 : 0

  bucket = var.log_bucket_name

  acl = "log-delivery-write"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  force_destroy = var.force_destroy

  lifecycle_rule {
    id      = "auto-archive"
    enabled = true

    prefix = "/"

    transition {
      days          = var.lifecycle_glacier_transition_days
      storage_class = "GLACIER"
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_policy" "access_log_policy" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id
  policy = data.aws_iam_policy_document.access_log_policy[0].json
}

resource "aws_s3_bucket_public_access_block" "access_log" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "content" {
  count = var.enabled ? 1 : 0

  bucket = var.bucket_name

  acl           = "private"
  force_destroy = var.force_destroy

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.access_log[0].id
  }

  versioning {
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
      days          = var.lifecycle_glacier_transition_days
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      days          = var.lifecycle_glacier_transition_days
      storage_class = "GLACIER"
    }
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "content" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.content[0].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
