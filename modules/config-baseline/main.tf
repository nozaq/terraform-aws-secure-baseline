data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# --------------------------------------------------------------------------------------------------
# Set up AWS Config recorder and let it publish results and send notifications.
# --------------------------------------------------------------------------------------------------

resource "aws_sns_topic" "config" {
  count = var.enabled ? 1 : 0

  name = var.sns_topic_name

  kms_master_key_id = var.sns_topic_kms_master_key_id

  tags = var.tags
}

resource "aws_sns_topic_policy" "config" {
  count = var.enabled ? 1 : 0
  arn   = aws_sns_topic.config[0].arn

  policy = data.aws_iam_policy_document.config-sns-policy[0].json
}

data "aws_iam_policy_document" "config-sns-policy" {
  count = var.enabled ? 1 : 0

  statement {
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.config[0].arn]

    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:config:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }
}

resource "aws_config_configuration_recorder" "recorder" {
  count = var.enabled ? 1 : 0

  name = var.recorder_name

  role_arn = var.iam_role_arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = var.include_global_resource_types
  }
}

resource "aws_config_delivery_channel" "bucket" {
  count = var.enabled ? 1 : 0

  name = var.delivery_channel_name

  s3_bucket_name = var.s3_bucket_name
  s3_key_prefix  = var.s3_key_prefix
  sns_topic_arn  = aws_sns_topic.config[0].arn

  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.recorder[0]]
}

resource "aws_config_configuration_recorder_status" "recorder" {
  count = var.enabled ? 1 : 0

  name = aws_config_configuration_recorder.recorder[0].id

  is_enabled = true
  depends_on = [aws_config_delivery_channel.bucket[0]]
}
