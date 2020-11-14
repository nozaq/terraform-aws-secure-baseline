data "aws_region" "current" {}
# --------------------------------------------------------------------------------------------------
# Enable SecurityHub
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_account" "main" {
  count = var.enabled ? 1 : 0
}

# --------------------------------------------------------------------------------------------------
# Add member accounts
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_member" "members" {
  count = var.enabled ? length(var.member_accounts) : 0

  depends_on = [aws_securityhub_account.main]
  account_id = var.member_accounts[count.index].account_id
  email      = var.member_accounts[count.index].email
  invite     = true
}

# --------------------------------------------------------------------------------------------------
# Subscribe CIS benchmark
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "cis" {
  count = var.enabled && var.enable_cis_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"

  depends_on = [aws_securityhub_account.main]
}

# --------------------------------------------------------------------------------------------------
# Subscribe AWS foundational security best practices standard
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "aws_foundational" {
  count = var.enabled && var.enable_aws_foundational_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"

  depends_on = [aws_securityhub_account.main]
}

# --------------------------------------------------------------------------------------------------
# Subscribe PCI DSS standard
# --------------------------------------------------------------------------------------------------
resource "aws_securityhub_standards_subscription" "pci_dss" {
  count = var.enabled && var.enable_pci_dss_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/pci-dss/v/3.2.1"

  depends_on = [aws_securityhub_account.main]
}
