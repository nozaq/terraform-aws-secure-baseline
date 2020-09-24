# --------------------------------------------------------------------------------------------------
# Password Policy
# --------------------------------------------------------------------------------------------------

resource "aws_iam_account_password_policy" "default" {
  minimum_password_length        = var.minimum_password_length
  password_reuse_prevention      = var.password_reuse_prevention
  require_lowercase_characters   = var.require_lowercase_characters
  require_numbers                = var.require_numbers
  require_uppercase_characters   = var.require_uppercase_characters
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password
  max_password_age               = var.max_password_age
  count                          = var.create_password_policy ? 1 : 0
}

# --------------------------------------------------------------------------------------------------
# Support Role
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "support_assume_policy" {
  statement {
    principals {
      type        = "AWS"
      identifiers = var.support_iam_role_principal_arns
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "support" {
  name               = var.support_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.support_assume_policy.json
  count              = var.create_support_role ? 1 : 0

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "support_policy" {
  role       = aws_iam_role.support[0].id
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
  count      = var.create_support_role ? 1 : 0
}

