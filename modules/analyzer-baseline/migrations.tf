# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Removing `enabled` argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_accessanalyzer_analyzer.default[0]
  to   = aws_accessanalyzer_analyzer.default
}
