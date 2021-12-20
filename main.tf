terraform {
  required_version = ">= 0.15"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"

      # A provider alias should be passed for each AWS region.
      # Reference: https://docs.aws.amazon.com/general/latest/gr/rande.html
      configuration_aliases = [
        aws.ap-northeast-1, aws.ap-northeast-2, aws.ap-northeast-3,
        aws.ap-south-1,
        aws.ap-southeast-1, aws.ap-southeast-2,
        aws.ca-central-1,
        aws.eu-central-1,
        aws.eu-north-1,
        aws.eu-west-1, aws.eu-west-2, aws.eu-west-3,
        aws.sa-east-1,
        aws.us-east-1, aws.us-east-2,
        aws.us-west-1, aws.us-west-2,
      ]
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  is_individual_account = var.account_type == "individual"
  is_master_account     = var.account_type == "master"
  is_member_account     = var.account_type == "member"

  is_cloudtrail_enabled = local.is_individual_account || local.is_master_account
}

# --------------------------------------------------------------------------------------------------
# IAM Baseline
# --------------------------------------------------------------------------------------------------

module "iam_baseline" {
  source = "./modules/iam-baseline"

  aws_account_id                  = var.aws_account_id
  support_iam_role_name           = var.support_iam_role_name
  support_iam_role_policy_name    = var.support_iam_role_policy_name
  support_iam_role_principal_arns = var.support_iam_role_principal_arns
  minimum_password_length         = var.minimum_password_length
  password_reuse_prevention       = var.password_reuse_prevention
  require_lowercase_characters    = var.require_lowercase_characters
  require_numbers                 = var.require_numbers
  require_uppercase_characters    = var.require_uppercase_characters
  require_symbols                 = var.require_symbols
  allow_users_to_change_password  = var.allow_users_to_change_password
  max_password_age                = var.max_password_age
  create_password_policy          = var.create_password_policy
  create_support_role             = var.create_support_role

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# CloudTrail Baseline
# --------------------------------------------------------------------------------------------------

module "cloudtrail_baseline" {
  source = "./modules/cloudtrail-baseline"

  enabled                           = local.is_cloudtrail_enabled
  aws_account_id                    = var.aws_account_id
  cloudtrail_depends_on             = [aws_s3_bucket_policy.audit_log]
  cloudtrail_name                   = var.cloudtrail_name
  cloudtrail_sns_topic_enabled      = var.cloudtrail_sns_topic_enabled
  cloudtrail_sns_topic_name         = var.cloudtrail_sns_topic_name
  cloudwatch_logs_enabled           = var.cloudtrail_cloudwatch_logs_enabled
  cloudwatch_logs_group_name        = var.cloudtrail_cloudwatch_logs_group_name
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  iam_role_name                     = var.cloudtrail_iam_role_name
  iam_role_policy_name              = var.cloudtrail_iam_role_policy_name
  key_deletion_window_in_days       = var.cloudtrail_key_deletion_window_in_days
  region                            = var.region
  s3_bucket_name                    = local.audit_log_bucket_id
  s3_key_prefix                     = var.cloudtrail_s3_key_prefix
  s3_object_level_logging_buckets   = var.cloudtrail_s3_object_level_logging_buckets
  dynamodb_event_logging_tables     = var.cloudtrail_dynamodb_event_logging_tables
  lambda_invocation_logging_lambdas = var.cloudtrail_lambda_invocation_logging_lambdas
  is_organization_trail             = local.is_master_account
  tags                              = var.tags
}

# --------------------------------------------------------------------------------------------------
# CloudWatch Alarms Baseline
# --------------------------------------------------------------------------------------------------

module "alarm_baseline" {
  source = "./modules/alarm-baseline"

  enabled                          = local.is_cloudtrail_enabled && var.cloudtrail_cloudwatch_logs_enabled
  unauthorized_api_calls_enabled   = var.unauthorized_api_calls_enabled
  no_mfa_console_signin_enabled    = var.no_mfa_console_signin_enabled
  mfa_console_signin_allow_sso     = var.mfa_console_signin_allow_sso
  root_usage_enabled               = var.root_usage_enabled
  iam_changes_enabled              = var.iam_changes_enabled
  cloudtrail_cfg_changes_enabled   = var.cloudtrail_cfg_changes_enabled
  console_signin_failures_enabled  = var.console_signin_failures_enabled
  disable_or_delete_cmk_enabled    = var.disable_or_delete_cmk_enabled
  s3_bucket_policy_changes_enabled = var.s3_bucket_policy_changes_enabled
  aws_config_changes_enabled       = var.aws_config_changes_enabled
  security_group_changes_enabled   = var.security_group_changes_enabled
  nacl_changes_enabled             = var.nacl_changes_enabled
  network_gw_changes_enabled       = var.network_gw_changes_enabled
  route_table_changes_enabled      = var.route_table_changes_enabled
  vpc_changes_enabled              = var.vpc_changes_enabled
  organizations_changes_enabled    = var.organizations_changes_enabled
  alarm_namespace                  = var.alarm_namespace
  cloudtrail_log_group_name        = local.is_cloudtrail_enabled ? module.cloudtrail_baseline.log_group : ""
  sns_topic_name                   = var.alarm_sns_topic_name
  sns_topic_kms_master_key_id      = var.alarm_sns_topic_kms_master_key_id

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# Macie Baseline
# --------------------------------------------------------------------------------------------------

module "macie_baseline" {
  source = "./modules/macie-baseline"

  enabled                      = contains(var.target_regions, "ap-northeast-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = var.master_account_id
  member_accounts              = var.member_accounts

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# S3 Baseline
# --------------------------------------------------------------------------------------------------

module "s3_baseline" {
  source = "./modules/s3-baseline"

  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}
