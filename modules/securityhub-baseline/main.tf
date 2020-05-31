# --------------------------------------------------------------------------------------------------
# Enable SecurityHub
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_account" "main" {
  count = var.enabled ? 1 : 0
}

# --------------------------------------------------------------------------------------------------
# Subscribe CIS benchmark
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "cis" {
  count = var.enabled ? 1 : 0

  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"

  depends_on = [aws_securityhub_account.main]
}

