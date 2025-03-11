data "aws_iam_policy_document" "access_log_policy" {
  statement {
    actions = ["s3:*"]
    effect  = "Deny"
    resources = [
      aws_s3_bucket.access_log.arn,
      "${aws_s3_bucket.access_log.arn}/*"
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

resource "aws_s3_bucket_ownership_controls" "access_log" {
  bucket = aws_s3_bucket.access_log.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket" "access_log" {
  bucket        = var.log_bucket_name
  force_destroy = var.force_destroy

  tags = var.tags
}

resource "aws_s3_bucket_acl" "access_log" {
  bucket = aws_s3_bucket.access_log.id
  acl    = "log-delivery-write"
  depends_on = [
    aws_s3_bucket_ownership_controls.access_log,
  ]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "access_log" {
  bucket = aws_s3_bucket.access_log.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "access_log" {
  count = var.lifecycle_glacier_transition_days > 0 ? 1 : 0

  bucket = aws_s3_bucket.access_log.id

  rule {
    id     = "auto-archive"
    status = "Enabled"

    filter {}

    transition {
      days          = var.lifecycle_glacier_transition_days
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_policy" "access_log_policy" {
  bucket = aws_s3_bucket.access_log.id
  policy = data.aws_iam_policy_document.access_log_policy.json

  depends_on = [
    aws_s3_bucket_public_access_block.access_log,
  ]
}

resource "aws_s3_bucket_public_access_block" "access_log" {
  bucket                  = aws_s3_bucket.access_log.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "content" {
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = var.tags

  depends_on = [
    aws_s3_bucket_public_access_block.access_log
  ]
}

resource "aws_s3_bucket_ownership_controls" "content" {
  bucket = aws_s3_bucket.content.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "content" {
  bucket = aws_s3_bucket.content.id
  acl    = "private"
  depends_on = [
    aws_s3_bucket_ownership_controls.content,
  ]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "content" {
  bucket = aws_s3_bucket.content.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = var.bucket_key_enabled
  }
}

resource "aws_s3_bucket_logging" "content" {
  bucket = aws_s3_bucket.content.id

  target_bucket = aws_s3_bucket.access_log.id
  target_prefix = ""
}

resource "aws_s3_bucket_lifecycle_configuration" "content" {
  count = var.lifecycle_glacier_transition_days > 0 ? 1 : 0

  bucket = aws_s3_bucket.content.id

  rule {
    id     = "auto-archive"
    status = "Enabled"

    filter {}

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
  bucket = aws_s3_bucket.content.id

  versioning_configuration {
    status = "Enabled"
    # Temporarily disabled due to Terraform issue.
    # https://github.com/terraform-providers/terraform-provider-aws/issues/629
    # mfa_delete = true
  }
}

resource "aws_s3_bucket_public_access_block" "content" {
  bucket                  = aws_s3_bucket.content.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
