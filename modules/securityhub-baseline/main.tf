data "aws_region" "current" {}

# --------------------------------------------------------------------------------------------------
# Enable SecurityHub
# --------------------------------------------------------------------------------------------------

resource "aws_securityhub_account" "main" {
}

resource "aws_securityhub_finding_aggregator" "main" {
  count = var.aggregate_findings && var.master_account_id == "" ? 1 : 0

  linking_mode = "ALL_REGIONS"

  depends_on = [aws_securityhub_account.main]
}

# --------------------------------------------------------------------------------------------------
# Add member accounts
# --------------------------------------------------------------------------------------------------

resource "aws_securityhub_member" "members" {
  count = length(var.member_accounts)

  depends_on = [aws_securityhub_account.main]
  account_id = var.member_accounts[count.index].account_id
  email      = var.member_accounts[count.index].email
  invite     = true
}

resource "aws_securityhub_invite_accepter" "invitee" {
  count = var.master_account_id != "" ? 1 : 0

  master_id = var.master_account_id

  depends_on = [aws_securityhub_account.main]
}

# --------------------------------------------------------------------------------------------------
# Subscribe standards
# --------------------------------------------------------------------------------------------------

resource "aws_securityhub_standards_subscription" "cis" {
  count = var.enable_cis_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/cis-aws-foundations-benchmark/v/1.4.0"

  depends_on = [aws_securityhub_account.main]
}

resource "aws_securityhub_standards_subscription" "aws_foundational" {
  count = var.enable_aws_foundational_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/aws-foundational-security-best-practices/v/1.0.0"

  depends_on = [aws_securityhub_account.main]
}

resource "aws_securityhub_standards_subscription" "pci_dss" {
  count = var.enable_pci_dss_standard ? 1 : 0

  standards_arn = "arn:aws:securityhub:${data.aws_region.current.name}::standards/pci-dss/v/3.2.1"

  depends_on = [aws_securityhub_account.main]
}

# 3rd party products
resource "aws_securityhub_product_subscription" "products" {
  count = length(var.enable_product_arns)

  product_arn = replace(var.enable_product_arns[count.index], "<REGION>", data.aws_region.current.name)

  depends_on = [aws_securityhub_account.main]
}
