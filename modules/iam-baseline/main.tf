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
}

# --------------------------------------------------------------------------------------------------
# Manager & Master Role Separation
# --------------------------------------------------------------------------------------------------

resource "aws_iam_role" "master" {
  name = var.master_iam_role_name

  assume_role_policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:root"
      }
    }
  ]
}
END_OF_POLICY
}

resource "aws_iam_role_policy" "master_policy" {
  name = var.master_iam_role_policy_name
  role = aws_iam_role.master.id

  policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:CreateGroup", "iam:CreatePolicy", "iam:CreatePolicyVersion", "iam:CreateRole", "iam:CreateUser",
        "iam:DeleteGroup", "iam:DeletePolicy", "iam:DeletePolicyVersion", "iam:DeleteRole", "iam:DeleteRolePolicy", "iam:DeleteUser",
        "iam:PutRolePolicy",
        "iam:GetPolicy", "iam:GetPolicyVersion", "iam:GetRole", "iam:GetRolePolicy", "iam:GetUser", "iam:GetUserPolicy",
        "iam:ListEntitiesForPolicy", "iam:ListGroupPolicies", "iam:ListGroups", "iam:ListGroupsForUser",
        "iam:ListPolicies", "iam:ListPoliciesGrantingServiceAccess", "iam:ListPolicyVersions",
        "iam:ListRolePolicies", "iam:ListAttachedGroupPolicies", "iam:ListAttachedRolePolicies",
        "iam:ListAttachedUserPolicies", "iam:ListRoles", "iam:ListUsers"
      ],
      "Resource": "*",
      "Condition":  {"Bool": {"aws:MultiFactorAuthPresent": "true"}}
    }, {
      "Effect": "Deny",
      "Action": [
        "iam:AddUserToGroup",
        "iam:AttachGroupPolicy",
        "iam:DeleteGroupPolicy", "iam:DeleteUserPolicy",
        "iam:DetachGroupPolicy", "iam:DetachRolePolicy", "iam:DetachUserPolicy",
        "iam:PutGroupPolicy", "iam:PutUserPolicy",
        "iam:RemoveUserFromGroup",
        "iam:UpdateGroup", "iam:UpdateAssumeRolePolicy", "iam:UpdateUser"
      ],
      "Resource": "*"
    }
  ]
}
END_OF_POLICY
}

resource "aws_iam_role" "manager" {
  name = var.manager_iam_role_name

  assume_role_policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:root"
      }
    }
  ]
}
END_OF_POLICY
}

resource "aws_iam_role_policy" "manager_policy" {
  name = var.manager_iam_role_policy_name
  role = aws_iam_role.manager.id

  policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:AddUserToGroup",
        "iam:AttachGroupPolicy",
        "iam:DeleteGroupPolicy", "iam:DeleteUserPolicy",
        "iam:DetachGroupPolicy", "iam:DetachRolePolicy","iam:DetachUserPolicy",
        "iam:PutGroupPolicy", "iam:PutUserPolicy",
        "iam:RemoveUserFromGroup",
        "iam:UpdateGroup", "iam:UpdateAssumeRolePolicy", "iam:UpdateUser",
        "iam:GetPolicy", "iam:GetPolicyVersion", "iam:GetRole", "iam:GetRolePolicy", "iam:GetUser", "iam:GetUserPolicy",
        "iam:ListEntitiesForPolicy", "iam:ListGroupPolicies", "iam:ListGroups", "iam:ListGroupsForUser",
        "iam:ListPolicies", "iam:ListPoliciesGrantingServiceAccess", "iam:ListPolicyVersions",
        "iam:ListRolePolicies", "iam:ListAttachedGroupPolicies", "iam:ListAttachedRolePolicies",
        "iam:ListAttachedUserPolicies", "iam:ListRoles", "iam:ListUsers"
      ],
      "Resource": "*",
      "Condition":  {"Bool": {"aws:MultiFactorAuthPresent": "true"}}
    }, {
      "Effect": "Deny",
      "Action": [
        "iam:CreateGroup", "iam:CreatePolicy", "iam:CreatePolicyVersion", "iam:CreateRole", "iam:CreateUser",
        "iam:DeleteGroup", "iam:DeletePolicy", "iam:DeletePolicyVersion", "iam:DeleteRole", "iam:DeleteRolePolicy", "iam:DeleteUser",
        "iam:PutRolePolicy"
      ],
      "Resource": "*"
    }
  ]
}
END_OF_POLICY
}

# --------------------------------------------------------------------------------------------------
# Support Role
# --------------------------------------------------------------------------------------------------

resource "aws_iam_role" "support" {
  name = var.support_iam_role_name

  assume_role_policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${var.support_iam_role_principal_arn}"
      }
    }
  ]
}
END_OF_POLICY

}

resource "aws_iam_role_policy_attachment" "support_policy" {
  role       = aws_iam_role.support.id
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}

