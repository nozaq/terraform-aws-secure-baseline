data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "org" {}

locals {
  is_org_root_account           = data.aws_caller_identity.current.account_id == data.aws_organizations_organization.org.master_account_id
  is_delegated_admin_account    = data.aws_caller_identity.current.account_id == var.delegated_admin_account_id
  is_securityhub_master_account = var.master_account_id == "" || (var.master_account_id == var.delegated_admin_account_id && local.is_delegated_admin_account)
  is_worker_account             = var.master_account_id != "" && !local.is_delegated_admin_account && !local.is_org_root_account
}

# --------------------------------------------------------------------------------------------------
# Enable SecurityHub
# --------------------------------------------------------------------------------------------------

resource "aws_securityhub_account" "main" {
  control_finding_generator = "SECURITY_CONTROL"
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
  count = local.is_securityhub_master_account ? length(var.member_accounts) : 0

  depends_on = [aws_securityhub_account.main]
  account_id = var.member_accounts[count.index].account_id
  email      = !local.is_delegated_admin_account ? var.member_accounts[count.index].email : null
  # invite     = !local.is_delegated_admin_account ? true : false
  invite     = true
}

resource "aws_securityhub_invite_accepter" "invitee" {
  count = local.is_worker_account && var.delegated_admin_account_id == "" ? 1 : 0

  master_id = var.master_account_id

  depends_on = [aws_securityhub_account.main]
}

# --------------------------------------------------------------------------------------------------
# Delegate administration to another account
# --------------------------------------------------------------------------------------------------

resource "aws_securityhub_organization_admin_account" "securityhub_baseline_delegated_admin" {
  count = local.is_org_root_account && var.delegated_admin_account_id != "" ? 1 : 0

  admin_account_id = var.delegated_admin_account_id

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
