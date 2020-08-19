# --------------------------------------------------------------------------------------------------
# Enables GuardDuty.
# --------------------------------------------------------------------------------------------------

resource "aws_guardduty_detector" "default" {
  count = var.enabled ? 1 : 0

  enable                       = true
  finding_publishing_frequency = var.finding_publishing_frequency

  tags = var.tags
}

resource "aws_guardduty_member" "members" {
  count = var.enabled ? length(var.member_accounts) : 0

  detector_id = aws_guardduty_detector.default[0].id
  invite      = true

  account_id                 = var.member_accounts[count.index].account_id
  disable_email_notification = var.disable_email_notification
  email                      = var.member_accounts[count.index].email
  invitation_message         = var.invitation_message
}

resource "aws_guardduty_invite_accepter" "master" {
  count = var.enabled && var.master_account_id != "" ? 1 : 0

  detector_id       = aws_guardduty_detector.default[0].id
  master_account_id = var.master_account_id
}
