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

  bucket        = var.log_bucket_name
  force_destroy = var.force_destroy

  tags = var.tags
}

resource "aws_s3_bucket_acl" "access_log" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "access_log" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "access_log" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id

  rule {
    id     = "auto-archive"
    status = "Enabled"

    prefix = "/"

    transition {
      days          = var.lifecycle_glacier_transition_days
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_policy" "access_log_policy" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.access_log[0].id
  policy = data.aws_iam_policy_document.access_log_policy[0].json

  depends_on = [
    aws_s3_bucket_public_access_block.access_log,
  ]
}

resource "aws_s3_bucket_public_access_block" "access_log" {
  count = var.enabled ? 1 : 0

  bucket                  = aws_s3_bucket.access_log[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "content" {
  count = var.enabled ? 1 : 0

  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = var.tags

  depends_on = [
    aws_s3_bucket_public_access_block.access_log
  ]
}

resource "aws_s3_bucket_acl" "content" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.content[0].id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "content" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.content[0].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = var.bucket_key_enabled
  }
}

resource "aws_s3_bucket_logging" "content" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.content[0].id

  target_bucket = aws_s3_bucket.access_log[0].id
  target_prefix = ""
}

resource "aws_s3_bucket_lifecycle_configuration" "content" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.content[0].id

  rule {
    id     = "auto-archive"
    status = "Enabled"

    prefix = "/"

    transition {
      days          = var.lifecycle_glacier_transition_days
      storage_class = "GLACIER"
    }

    noncurrent_version_transition {
      noncurrent_days = var.lifecycle_glacier_transition_days
      storage_class   = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_versioning" "content" {
  count = var.enabled ? 1 : 0

  bucket = aws_s3_bucket.content[0].id

  versioning_configuration {
    status = "Enabled"
    # Temporarily disabled due to Terraform issue.
    # https://github.com/terraform-providers/terraform-provider-aws/issues/629
    # mfa_delete = true
  }
}

resource "aws_s3_bucket_public_access_block" "content" {
  count = var.enabled ? 1 : 0

  bucket                  = aws_s3_bucket.content[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

