data "aws_caller_identity" "current" {}

data "aws_organizations_organization" "org" {}

locals {
  is_org_root_account         = data.aws_caller_identity.current.account_id == data.aws_organizations_organization.org.master_account_id
  is_delegated_admin_account  = data.aws_caller_identity.current.account_id == var.delegated_admin_account_id
  is_guardduty_master_account = var.master_account_id == "" || (var.master_account_id == var.delegated_admin_account_id && local.is_delegated_admin_account)
  is_worker_account           = var.master_account_id != "" && !local.is_delegated_admin_account && !local.is_org_root_account

  member_accounts_map = {for member in var.member_accounts : member.account_id => {"email" = member.email}}
  member_account_features_map = merge([
    for member in var.member_accounts : {
      for feature in var.detector_features:
        "${member.account_id}_${feature}" => {
          "member_account_id" = member.account_id
          "feature" = feature
        }
    }
  ]...)
}

resource "aws_guardduty_detector" "default" {
  enable                       = true
  finding_publishing_frequency = var.finding_publishing_frequency

  tags = var.tags
}

resource "aws_guardduty_organization_admin_account" "guardduty_baseline_delegated_admin" {
  count = local.is_org_root_account && var.delegated_admin_account_id != "" ? 1 : 0

  admin_account_id = var.delegated_admin_account_id
}

resource "aws_guardduty_member" "members" {
  # count = local.is_guardduty_master_account ? length(var.member_accounts) : 0
  for_each = local.is_guardduty_master_account ? local.member_accounts_map : {}

  detector_id                = aws_guardduty_detector.default.id
  invite                     = true
  # account_id                 = var.member_accounts[count.index].account_id
  account_id                 = each.key
  disable_email_notification = var.disable_email_notification
  # email                      = var.member_accounts[count.index].email
  email                      = each.value.email
  invitation_message         = var.invitation_message

  lifecycle {
    ignore_changes = [
      email,
    ]
  }
}

resource "aws_guardduty_invite_accepter" "master" {
  count = local.is_worker_account && var.delegated_admin_account_id == "" ? 1 : 0

  detector_id       = aws_guardduty_detector.default.id
  master_account_id = var.master_account_id
}

resource "aws_guardduty_detector_feature" "default_detector_features" {
  for_each = local.is_guardduty_master_account && local.is_delegated_admin_account ? local.member_account_features_map : {}

  detector_id = split(":", aws_guardduty_member.members[each.value.member_account_id].id)[0]
  name        = each.value.feature
  status      = "ENABLED"
}
