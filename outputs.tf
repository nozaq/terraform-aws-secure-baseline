# --------------------------------------------------------------------------------------------------
# Outputs from the root module.
# --------------------------------------------------------------------------------------------------

output "audit_bucket" {
  description = "The S3 bucket used for storing audit logs."
  value       = module.audit_log_bucket.this_bucket
}

# --------------------------------------------------------------------------------------------------
# Outputs from alarm-baseline module.
# --------------------------------------------------------------------------------------------------

output "alarm_sns_topic" {
  description = "The SNS topic to which CloudWatch Alarms will be sent."
  value       = module.alarm_baseline.alarm_sns_topic
}

# --------------------------------------------------------------------------------------------------
# Outputs from cloudtrail-baseline module.
# --------------------------------------------------------------------------------------------------

output "cloudtrail" {
  description = "The trail for recording events in all regions."
  value       = module.cloudtrail_baseline.cloudtrail
}

output "cloudtrail_sns_topic" {
  description = "The sns topic linked to the cloudtrail."
  value       = module.cloudtrail_baseline.cloudtrail_sns_topic
}

output "cloudtrail_kms_key" {
  description = "The KMS key used for encrypting CloudTrail events."
  value       = module.cloudtrail_baseline.kms_key
}

output "cloudtrail_log_delivery_iam_role" {
  description = "The IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = module.cloudtrail_baseline.log_delivery_iam_role
}

output "cloudtrail_log_group" {
  description = "The CloudWatch Logs log group which stores CloudTrail events."
  value       = module.cloudtrail_baseline.log_group
}

# --------------------------------------------------------------------------------------------------
# Outputs from config-baseline module.
# --------------------------------------------------------------------------------------------------

output "config_iam_role" {
  description = "The IAM role used for delivering AWS Config records to CloudWatch Logs."
  value       = aws_iam_role.recorder
}

output "config_configuration_recorder" {
  description = "The configuration recorder in each region."

  value = {
    "ap-northeast-1" = module.config_baseline_ap-northeast-1.configuration_recorder
    "ap-northeast-2" = module.config_baseline_ap-northeast-2.configuration_recorder
    "ap-south-1"     = module.config_baseline_ap-south-1.configuration_recorder
    "ap-southeast-1" = module.config_baseline_ap-southeast-1.configuration_recorder
    "ap-southeast-2" = module.config_baseline_ap-southeast-2.configuration_recorder
    "ca-central-1"   = module.config_baseline_ca-central-1.configuration_recorder
    "eu-central-1"   = module.config_baseline_eu-central-1.configuration_recorder
    "eu-west-1"      = module.config_baseline_eu-west-1.configuration_recorder
    "eu-west-2"      = module.config_baseline_eu-west-2.configuration_recorder
    "eu-west-3"      = module.config_baseline_eu-west-3.configuration_recorder
    "sa-east-1"      = module.config_baseline_sa-east-1.configuration_recorder
    "us-east-1"      = module.config_baseline_us-east-1.configuration_recorder
    "us-east-2"      = module.config_baseline_us-east-2.configuration_recorder
    "us-west-1"      = module.config_baseline_us-west-1.configuration_recorder
    "us-west-2"      = module.config_baseline_us-west-2.configuration_recorder
  }
}

output "config_sns_topic" {
  description = "The SNS topic that AWS Config delivers notifications to."

  value = {
    "ap-northeast-1" = module.config_baseline_ap-northeast-1.config_sns_topic
    "ap-northeast-2" = module.config_baseline_ap-northeast-2.config_sns_topic
    "ap-south-1"     = module.config_baseline_ap-south-1.config_sns_topic
    "ap-southeast-1" = module.config_baseline_ap-southeast-1.config_sns_topic
    "ap-southeast-2" = module.config_baseline_ap-southeast-2.config_sns_topic
    "ca-central-1"   = module.config_baseline_ca-central-1.config_sns_topic
    "eu-central-1"   = module.config_baseline_eu-central-1.config_sns_topic
    "eu-north-1"     = module.config_baseline_eu-north-1.config_sns_topic
    "eu-west-1"      = module.config_baseline_eu-west-1.config_sns_topic
    "eu-west-2"      = module.config_baseline_eu-west-2.config_sns_topic
    "eu-west-3"      = module.config_baseline_eu-west-3.config_sns_topic
    "sa-east-1"      = module.config_baseline_sa-east-1.config_sns_topic
    "us-east-1"      = module.config_baseline_us-east-1.config_sns_topic
    "us-east-2"      = module.config_baseline_us-east-2.config_sns_topic
    "us-west-1"      = module.config_baseline_us-west-1.config_sns_topic
    "us-west-2"      = module.config_baseline_us-west-2.config_sns_topic
  }
}

# --------------------------------------------------------------------------------------------------
# Outputs from guardduty-baseline module.
# --------------------------------------------------------------------------------------------------

output "guardduty_detector" {
  description = "The GuardDuty detector in each region."

  value = {
    "ap-northeast-1" = module.guardduty_baseline_ap-northeast-1.guardduty_detector
    "ap-northeast-2" = module.guardduty_baseline_ap-northeast-2.guardduty_detector
    "ap-south-1"     = module.guardduty_baseline_ap-south-1.guardduty_detector
    "ap-southeast-1" = module.guardduty_baseline_ap-southeast-1.guardduty_detector
    "ap-southeast-2" = module.guardduty_baseline_ap-southeast-2.guardduty_detector
    "ca-central-1"   = module.guardduty_baseline_ca-central-1.guardduty_detector
    "eu-central-1"   = module.guardduty_baseline_eu-central-1.guardduty_detector
    "eu-north-1"     = module.guardduty_baseline_eu-north-1.guardduty_detector
    "eu-west-1"      = module.guardduty_baseline_eu-west-1.guardduty_detector
    "eu-west-2"      = module.guardduty_baseline_eu-west-2.guardduty_detector
    "sa-east-1"      = module.guardduty_baseline_sa-east-1.guardduty_detector
    "us-east-1"      = module.guardduty_baseline_us-east-1.guardduty_detector
    "us-east-2"      = module.guardduty_baseline_us-east-2.guardduty_detector
    "us-west-1"      = module.guardduty_baseline_us-west-1.guardduty_detector
    "us-west-2"      = module.guardduty_baseline_us-west-2.guardduty_detector
  }
}

# --------------------------------------------------------------------------------------------------
# Outputs from iam-baseline module.
# --------------------------------------------------------------------------------------------------

output "master_iam_role" {
  description = "The IAM role used for the master user."
  value       = module.iam_baseline.master_iam_role
}

output "manager_iam_role" {
  description = "The IAM role used for the manager user."
  value       = module.iam_baseline.manager_iam_role
}

output "support_iam_role" {
  description = "The IAM role used for the support user."
  value       = module.iam_baseline.support_iam_role
}
