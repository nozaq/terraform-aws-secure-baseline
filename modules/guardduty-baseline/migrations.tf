# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Removing `enabled` argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_guardduty_detector.default[0]
  to   = aws_guardduty_detector.default
}
