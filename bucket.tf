# --------------------------------------------------------------------------------------------------
# Configure the S3 bucket to store audit logs.
# --------------------------------------------------------------------------------------------------
locals {
  use_external_bucket = var.use_external_audit_log_bucket

  audit_log_bucket_id  = local.use_external_bucket ? data.aws_s3_bucket.external[0].id : module.audit_log_bucket.this_bucket.id
  audit_log_bucket_arn = local.use_external_bucket ? data.aws_s3_bucket.external[0].arn : module.audit_log_bucket.this_bucket.arn
}

# --------------------------------------------------------------------------------------------------
# Case 1. Use the external S3 bucket.
# --------------------------------------------------------------------------------------------------
data "aws_s3_bucket" "external" {
  count  = local.use_external_bucket ? 1 : 0
  bucket = var.audit_log_bucket_name
}

# --------------------------------------------------------------------------------------------------
# Case 2. Create a new S3 bucket.
#
# Create a S3 bucket to store various audit logs.
# Bucket policies are derived from the default bucket policy described in
# AWS Config Developer Guide and AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
# --------------------------------------------------------------------------------------------------
module "audit_log_bucket" {
  source = "./modules/secure-bucket"

  bucket_name                       = var.audit_log_bucket_name
  log_bucket_name                   = "${var.audit_log_bucket_name}-access-logs"
  lifecycle_glacier_transition_days = var.audit_log_lifecycle_glacier_transition_days
  force_destroy                     = var.audit_log_bucket_force_destroy
  enabled                           = ! local.use_external_bucket

  tags = var.tags
}

data "aws_organizations_organization" "org" {
  count = local.is_individual_account ? 0 : 1
}

data "aws_iam_policy_document" "audit_log" {
  count = local.use_external_bucket ? 0 : 1

  override_json = var.audit_log_bucket_custom_policy_json

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
    resources = concat(
      ["${module.audit_log_bucket.this_bucket.arn}/config/AWSLogs/${var.aws_account_id}/Config/*"],
      local.is_master_account ? [for account in var.member_accounts : "${module.audit_log_bucket.this_bucket.arn}/config/AWSLogs/${account.account_id}/Config/*"] : []
    )
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
    resources = concat(
      ["${module.audit_log_bucket.this_bucket.arn}/cloudtrail/AWSLogs/${var.aws_account_id}/*"],
      local.is_master_account ? ["${module.audit_log_bucket.this_bucket.arn}/cloudtrail/AWSLogs/${data.aws_organizations_organization.org[0].id}/*"] : []
    )
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  dynamic "statement" {
    for_each = local.is_master_account && length(var.member_accounts) > 0 ? [var.member_accounts] : []

    content {
      principals {
        type        = "AWS"
        identifiers = [for account in statement.value : "arn:aws:iam::${account.account_id}:root"]
      }
      actions   = ["s3:GetBucketLocation", "s3:ListBucket"]
      resources = [module.audit_log_bucket.this_bucket.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "audit_log" {
  count = local.use_external_bucket ? 0 : 1

  bucket = module.audit_log_bucket.this_bucket.id
  policy = data.aws_iam_policy_document.audit_log[0].json
}
