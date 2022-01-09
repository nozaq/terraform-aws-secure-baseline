resource "aws_guardduty_detector" "default" {
  enable                       = true
  finding_publishing_frequency = var.finding_publishing_frequency

  # datasources can't be individually managed in each member account.
  dynamic "datasources" {
    for_each = var.master_account_id == "" ? [var.master_account_id] : []

    content {
      s3_logs {
        enable = true
      }
    }
  }

  tags = var.tags
}

resource "aws_guardduty_member" "members" {
  count = length(var.member_accounts)

  detector_id                = aws_guardduty_detector.default.id
  invite                     = true
  account_id                 = var.member_accounts[count.index].account_id
  disable_email_notification = var.disable_email_notification
  email                      = var.member_accounts[count.index].email
  invitation_message         = var.invitation_message
}

resource "aws_guardduty_invite_accepter" "master" {
  count = var.master_account_id != "" ? 1 : 0

  detector_id       = aws_guardduty_detector.default.id
  master_account_id = var.master_account_id
}
