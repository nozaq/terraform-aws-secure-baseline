# --------------------------------------------------------------------------------------------------
# Configure the S3 bucket to store audit logs.
# --------------------------------------------------------------------------------------------------
locals {
  use_external_bucket = var.use_external_audit_log_bucket

  audit_log_bucket_id  = local.use_external_bucket ? data.aws_s3_bucket.external[0].id : module.audit_log_bucket.this_bucket.id
  audit_log_bucket_arn = local.use_external_bucket ? data.aws_s3_bucket.external[0].arn : module.audit_log_bucket.this_bucket.arn

  audit_log_cloudtrail_destination = join("/", [local.audit_log_bucket_arn, trim(var.cloudtrail_s3_key_prefix, "/")])
  audit_log_config_destination     = join("/", [local.audit_log_bucket_arn, trim(var.config_s3_bucket_key_prefix, "/")])
  audit_log_flow_logs_destination  = join("/", [local.audit_log_bucket_arn, trim(var.vpc_flow_logs_s3_key_prefix, "/")])

  flow_logs_use_s3 = var.vpc_flow_logs_destination_type == "s3"
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
# Bucket policies are derived from the default bucket policy and official AWS documents.
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

# --------------------------------------------------------------------------------------------------
# Apply policies to enforce SSL connections.
# https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-ssl-requests-only.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "audit_log_base" {
  count = local.use_external_bucket ? 0 : 1

  statement {
    actions = ["s3:*"]
    effect  = "Deny"
    resources = [
      module.audit_log_bucket.this_bucket.arn,
      "${module.audit_log_bucket.this_bucket.arn}/*"
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

# --------------------------------------------------------------------------------------------------
# Apply policies for CloudTrail log delivery based on AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "audit_log_cloud_trail" {
  count = local.use_external_bucket ? 0 : 1

  source_json = data.aws_iam_policy_document.audit_log_base[0].json

  statement {
    sid     = "AWSCloudTrailAclCheck20150319"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = [module.audit_log_bucket.this_bucket.arn]
  }

  statement {
    sid     = "AWSCloudTrailWrite20150319"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    resources = concat(
      ["${local.audit_log_cloudtrail_destination}/AWSLogs/${var.aws_account_id}/*"],
      local.is_master_account ? ["${local.audit_log_cloudtrail_destination}/AWSLogs/${data.aws_organizations_organization.org[0].id}/*"] : []
    )
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

# --------------------------------------------------------------------------------------------------
# Apply policies for AWS Config log delivery based on AWS Config Developer Guide.
# https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "audit_log_config" {
  count = local.use_external_bucket ? 0 : 1

  source_json = data.aws_iam_policy_document.audit_log_cloud_trail[0].json

  statement {
    sid     = "AWSConfigBucketPermissionsCheck"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = [module.audit_log_bucket.this_bucket.arn]
  }

  statement {
    sid     = "AWSConfigBucketExistenceCheck"
    actions = ["s3:ListBucket"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = [module.audit_log_bucket.this_bucket.arn]
  }

  statement {
    sid     = "AWSConfigBucketDelivery"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = concat(
      ["${local.audit_log_config_destination}/AWSLogs/${var.aws_account_id}/Config/*"],
      local.is_master_account ? [for account in var.member_accounts : "${local.audit_log_config_destination}/AWSLogs/${account.account_id}/Config/*"] : []
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
      sid = "AWSConfigBucketPermissionsCheckForMemberAccounts"
      principals {
        type        = "AWS"
        identifiers = [for account in statement.value : "arn:aws:iam::${account.account_id}:root"]
      }
      actions   = ["s3:GetBucketAcl"]
      resources = [module.audit_log_bucket.this_bucket.arn]
    }
  }

  dynamic "statement" {
    for_each = local.is_master_account && length(var.member_accounts) > 0 ? [var.member_accounts] : []

    content {
      sid = "AWSConfigBucketExistenceCheckForMemberAccounts"
      principals {
        type        = "AWS"
        identifiers = [for account in statement.value : "arn:aws:iam::${account.account_id}:root"]
      }
      actions   = ["s3:ListBucket", "s3:GetBucketLocation"]
      resources = [module.audit_log_bucket.this_bucket.arn]
    }
  }

  dynamic "statement" {
    for_each = local.is_master_account && length(var.member_accounts) > 0 ? [var.member_accounts] : []

    content {
      sid = "AWSConfigBucketDeliveryForMemberAccounts"
      principals {
        type        = "AWS"
        identifiers = [for account in statement.value : "arn:aws:iam::${account.account_id}:root"]
      }
      actions   = ["s3:PutObject"]
      resources = [for account in statement.value : "${local.audit_log_config_destination}/AWSLogs/${account.account_id}/Config/*"]
      condition {
        test     = "StringEquals"
        variable = "s3:x-amz-acl"
        values   = ["bucket-owner-full-control"]
      }
    }
  }
}

# --------------------------------------------------------------------------------------------------
# Apply policies for AWS Config log delivery based on Amazon Virtual Private Cloud User Guide.
# This policy is necessary only when the log destination of VPC Flow Logs is set to S3.
# https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs-s3.html#flow-logs-s3-permissions
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "audit_log_flow_logs" {
  count = ! local.use_external_bucket && local.flow_logs_use_s3 ? 1 : 0

  source_json = data.aws_iam_policy_document.audit_log_config[0].json

  statement {
    sid     = "AWSLogDeliveryAclCheck"
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    resources = [module.audit_log_bucket.this_bucket.arn]
  }

  statement {
    sid     = "AWSLogDeliveryWrite"
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    resources = concat(
      ["${local.audit_log_flow_logs_destination}/AWSLogs/${var.aws_account_id}/*"],
      local.is_master_account ? [for account in var.member_accounts : "${local.audit_log_flow_logs_destination}/AWSLogs/${account.account_id}/*"] : []
    )
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}


data "aws_iam_policy_document" "audit_log" {
  count = local.use_external_bucket ? 0 : 1

  source_json   = local.flow_logs_use_s3 ? data.aws_iam_policy_document.audit_log_flow_logs[0].json : data.aws_iam_policy_document.audit_log_config[0].json
  override_json = var.audit_log_bucket_custom_policy_json
}

resource "aws_s3_bucket_policy" "audit_log" {
  count = local.use_external_bucket ? 0 : 1

  bucket = module.audit_log_bucket.this_bucket.id
  policy = data.aws_iam_policy_document.audit_log[0].json
}
