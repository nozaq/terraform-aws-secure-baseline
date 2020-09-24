# --------------------------------------------------------------------------------------------------
# Set up AWS Config recorder and let it publish results and send notifications.
# --------------------------------------------------------------------------------------------------

resource "aws_sns_topic" "config" {
  count = var.enabled ? 1 : 0

  name = var.sns_topic_name

  tags = var.tags
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
