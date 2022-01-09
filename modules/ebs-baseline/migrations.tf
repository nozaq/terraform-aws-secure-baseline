# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Removing `enabled` argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_ebs_encryption_by_default.this[0]
  to   = aws_ebs_encryption_by_default.this
}
