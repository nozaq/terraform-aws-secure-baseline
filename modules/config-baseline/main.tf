resource "aws_sns_topic" "config" {
  name = "${var.sns_topic_name}"
}

resource "aws_config_configuration_recorder" "recorder" {
  name = "${var.recorder_name}"

  role_arn = "${var.iam_role_arn}"

  recording_group = {
    all_supported                 = "true"
    include_global_resource_types = "true"
  }
}

resource "aws_config_delivery_channel" "bucket" {
  name = "${var.delivery_channel_name}"

  s3_bucket_name = "${var.s3_bucket_name}"
  s3_key_prefix  = "${var.s3_key_prefix}"
  sns_topic_arn  = "${aws_sns_topic.config.arn}"

  snapshot_delivery_properties = {
    delivery_frequency = "${var.delivery_frequency}"
  }

  depends_on = ["aws_config_configuration_recorder.recorder"]
}

resource "aws_config_configuration_recorder_status" "recorder" {
  name = "${aws_config_configuration_recorder.recorder.id}"

  is_enabled = true
  depends_on = ["aws_config_delivery_channel.bucket"]
}
