# --------------------------------------------------------------------------------------------------
# Enables GuardDuty.
# --------------------------------------------------------------------------------------------------

resource "aws_guardduty_detector" "default" {
  enable                       = true
  finding_publishing_frequency = var.finding_publishing_frequency
}

resource "aws_guardduty_member" "members" {
  count = length(var.member_accounts)

  account_id         = var.member_accounts[count.index].account_id
  detector_id        = aws_guardduty_detector.default.id
  email              = var.member_accounts[count.index].email
  invite             = true
  invitation_message = var.invitation_message
}

resource "aws_guardduty_invite_accepter" "master" {
  count = var.master_account_id != "" ? 1 : 0

  detector_id       = aws_guardduty_detector.default.id
  master_account_id = var.master_account_id
}
