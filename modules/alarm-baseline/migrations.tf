# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Removing `enabled` argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_sns_topic.alarms[0]
  to   = aws_sns_topic.alarms
}

moved {
  from = aws_sns_topic_policy.alarms[0]
  to   = aws_sns_topic_policy.alarms
}
