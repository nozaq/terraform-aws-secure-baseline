# --------------------------------------------------------------------------------------------------
# CloudWatch Logs group to accept CloudTrail event stream.
# --------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "cloudtrail_events" {
  count = var.cloudwatch_logs_enabled && var.enabled ? 1 : 0

  name              = var.cloudwatch_logs_group_name
  retention_in_days = var.cloudwatch_logs_retention_in_days

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# IAM Role to deliver CloudTrail events to CloudWatch Logs group.
# The policy was derived from the default key policy descrived in AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "cloudwatch_delivery_assume_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "cloudwatch_delivery" {
  count = var.cloudwatch_logs_enabled && var.enabled ? 1 : 0

  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_delivery_assume_policy.json

  tags = var.tags
}

data "aws_iam_policy_document" "cloudwatch_delivery_policy" {
  count = var.cloudwatch_logs_enabled && var.enabled ? 1 : 0

  statement {
    sid       = "AWSCloudTrailCreateLogStream2014110"
    actions   = ["logs:CreateLogStream"]
    resources = ["arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail_events[0].name}:log-stream:*"]
  }

  statement {
    sid       = "AWSCloudTrailPutLogEvents20141101"
    actions   = ["logs:PutLogEvents"]
    resources = ["arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail_events[0].name}:log-stream:*"]
  }
}

resource "aws_iam_role_policy" "cloudwatch_delivery_policy" {
  count = var.cloudwatch_logs_enabled && var.enabled ? 1 : 0

  name = var.iam_role_policy_name
  role = aws_iam_role.cloudwatch_delivery[0].id

  policy = data.aws_iam_policy_document.cloudwatch_delivery_policy[0].json
}

# --------------------------------------------------------------------------------------------------
# KMS Key to encrypt CloudTrail events.
# The policy was derived from the default key policy described in AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/default-cmk-policy.html
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "cloudtrail_key_policy" {
  policy_id = "Key policy created by CloudTrail"

  statement {
    sid = "Enable IAM User Permissions"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.aws_account_id}:root"
      ]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    sid = "Allow CloudTrail to encrypt logs"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:GenerateDataKey*"]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${var.aws_account_id}:trail/*"]
    }
  }

  statement {
    sid = "Allow CloudTrail to describe key"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["kms:DescribeKey"]
    resources = ["*"]
  }

  statement {
    sid = "Allow principals in the account to decrypt log files"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [var.aws_account_id]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${var.aws_account_id}:trail/*"]
    }
  }

  statement {
    sid = "Allow alias creation during setup"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:CreateAlias"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["ec2.${var.region}.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [var.aws_account_id]
    }
  }

  statement {
    sid = "Enable cross account log decryption"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = [
      "kms:Decrypt",
      "kms:ReEncryptFrom"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"
      values   = [var.aws_account_id]
    }
    condition {
      test     = "StringLike"
      variable = "kms:EncryptionContext:aws:cloudtrail:arn"
      values   = ["arn:aws:cloudtrail:*:${var.aws_account_id}:trail/*"]
    }
  }

  # https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-permissions-for-sns-notifications.html
  statement {
    sid = "Allow CloudTrail to send notifications to the encrypted SNS topic"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    resources = ["*"]
  }
}

resource "aws_kms_key" "cloudtrail" {
  count = var.enabled ? 1 : 0

  description             = "A KMS key to encrypt CloudTrail events."
  deletion_window_in_days = var.key_deletion_window_in_days
  enable_key_rotation     = "true"

  policy = data.aws_iam_policy_document.cloudtrail_key_policy.json

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# SNS Topic
# Could be used as subscription target to get feed of audit trail messages
# --------------------------------------------------------------------------------------------------

resource "aws_sns_topic" "cloudtrail-sns-topic" {
  count = var.cloudtrail_sns_topic_enabled && var.enabled ? 1 : 0

  name              = var.cloudtrail_sns_topic_name
  kms_master_key_id = aws_kms_key.cloudtrail[0].id
}

data "aws_iam_policy_document" "cloudtrail-sns-policy" {
  count = var.cloudtrail_sns_topic_enabled && var.enabled ? 1 : 0

  statement {
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.cloudtrail-sns-topic[0].arn]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_sns_topic_policy" "local-account-cloudtrail" {
  count = var.cloudtrail_sns_topic_enabled && var.enabled ? 1 : 0

  arn    = aws_sns_topic.cloudtrail-sns-topic[0].arn
  policy = data.aws_iam_policy_document.cloudtrail-sns-policy[0].json
}

# --------------------------------------------------------------------------------------------------
# CloudTrail configuration.
# --------------------------------------------------------------------------------------------------

resource "aws_cloudtrail" "global" {
  count = var.enabled ? 1 : 0

  name = var.cloudtrail_name

  cloud_watch_logs_group_arn    = var.cloudwatch_logs_enabled ? "${aws_cloudwatch_log_group.cloudtrail_events[0].arn}:*" : null
  cloud_watch_logs_role_arn     = var.cloudwatch_logs_enabled ? aws_iam_role.cloudwatch_delivery[0].arn : null
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = true
  is_organization_trail         = var.is_organization_trail
  kms_key_id                    = aws_kms_key.cloudtrail[0].arn
  s3_bucket_name                = var.s3_bucket_name
  s3_key_prefix                 = var.s3_key_prefix
  sns_topic_name                = var.cloudtrail_sns_topic_enabled ? aws_sns_topic.cloudtrail-sns-topic[0].arn : null

  event_selector {
    read_write_type           = "All"
    include_management_events = true

    data_resource {
      type   = "AWS::S3::Object"
      values = var.s3_object_level_logging_buckets
    }
  }

  tags = var.tags

  depends_on = [var.cloudtrail_depends_on]
}
