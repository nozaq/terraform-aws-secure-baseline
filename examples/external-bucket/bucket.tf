resource "aws_s3_bucket" "logs" {
  bucket        = var.audit_s3_bucket_name
  acl           = "private"
  force_destroy = true
}

data "aws_iam_policy_document" "logs_bucket_policy" {
  statement {
    sid     = "AWSCloudTrailAclCheckForConfig"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = [module.audit_log_bucket.this_bucket.arn]
  }

  statement {
    sid     = "AWSCloudTrailWriteForConfig"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["${module.audit_log_bucket.this_bucket.arn}/config/AWSLogs/${var.aws_account_id}/Config/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid     = "AWSCloudTrailAclCheckForCloudTrail"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [module.audit_log_bucket.this_bucket.arn]
  }

  statement {
    sid     = "AWSCloudTrailWriteForCloudTrail"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = ["${module.audit_log_bucket.this_bucket.arn}/cloudtrail/AWSLogs/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "logs" {
  bucket = aws_s3_bucket.logs.id
  policy = data.aws_iam_policy_document.logs_bucket_policy.json
}
