data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "org" {}

resource "aws_accessanalyzer_analyzer" "default" {
  analyzer_name = var.analyzer_name
  type          = var.is_organization ? "ORGANIZATION" : "ACCOUNT"

  tags = var.tags
}

resource "aws_organizations_delegated_administrator" "accessanalyzer_analyzer_baseline_delegated_admin" {
  count = var.is_organization && data.aws_caller_identity.current.account_id == data.aws_organizations_organization.org.master_account_id && var.delegated_admin_account_id != "" ? 1 : 0

  account_id        = var.delegated_admin_account_id
  service_principal = "access-analyzer.amazonaws.com"
}
