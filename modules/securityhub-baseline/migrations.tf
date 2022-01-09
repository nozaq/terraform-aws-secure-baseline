
# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Removing `enabled` argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_securityhub_account.main[0]
  to   = aws_securityhub_account.main
}
