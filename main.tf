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

  tags = var.tags
}
