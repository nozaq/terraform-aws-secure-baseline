# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Removing `enabled` argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_sns_topic.config[0]
  to   = aws_sns_topic.config
}

moved {
  from = aws_sns_topic_policy.config[0]
  to   = aws_sns_topic_policy.config
}

moved {
  from = aws_config_configuration_recorder.recorder[0]
  to   = aws_config_configuration_recorder.recorder
}

moved {
  from = aws_config_configuration_recorder_status.recorder[0]
  to   = aws_config_configuration_recorder_status.recorder
}

moved {
  from = aws_config_delivery_channel.bucket[0]
  to   = aws_config_delivery_channel.bucket
}
