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

output "support_iam_role" {
  description = "The IAM role used for the support user."
  value       = module.iam_baseline.support_iam_role
}

# --------------------------------------------------------------------------------------------------
# Outputs from vpc-baseline module.
# --------------------------------------------------------------------------------------------------

output "vpc_flow_logs_iam_role" {
  description = "The IAM role used for delivering VPC Flow Logs to CloudWatch Logs."
  value       = local.is_cw_logs ? aws_iam_role.flow_logs_publisher : null
}

output "vpc_flow_logs_group" {
  description = "The CloudWatch Logs log group which stores VPC Flow Logs in each region."

  value = local.is_cw_logs ? {
    "ap-northeast-1" = module.vpc_baseline_ap-northeast-1.vpc_flow_logs_group
    "ap-northeast-2" = module.vpc_baseline_ap-northeast-2.vpc_flow_logs_group
    "ap-south-1"     = module.vpc_baseline_ap-south-1.vpc_flow_logs_group
    "ap-southeast-1" = module.vpc_baseline_ap-southeast-1.vpc_flow_logs_group
    "ap-southeast-2" = module.vpc_baseline_ap-southeast-2.vpc_flow_logs_group
    "ca-central-1"   = module.vpc_baseline_ca-central-1.vpc_flow_logs_group
    "eu-central-1"   = module.vpc_baseline_eu-central-1.vpc_flow_logs_group
    "eu-north-1"     = module.vpc_baseline_eu-north-1.vpc_flow_logs_group
    "eu-west-1"      = module.vpc_baseline_eu-west-1.vpc_flow_logs_group
    "eu-west-2"      = module.vpc_baseline_eu-west-2.vpc_flow_logs_group
    "eu-west-3"      = module.vpc_baseline_eu-west-3.vpc_flow_logs_group
    "sa-east-1"      = module.vpc_baseline_sa-east-1.vpc_flow_logs_group
    "us-east-1"      = module.vpc_baseline_us-east-1.vpc_flow_logs_group
    "us-east-2"      = module.vpc_baseline_us-east-2.vpc_flow_logs_group
    "us-west-1"      = module.vpc_baseline_us-west-1.vpc_flow_logs_group
    "us-west-2"      = module.vpc_baseline_us-west-2.vpc_flow_logs_group
  } : null
}

output "default_vpc" {
  description = "The default VPC."

  value = {
    "ap-northeast-1" = module.vpc_baseline_ap-northeast-1.default_vpc
    "ap-northeast-2" = module.vpc_baseline_ap-northeast-2.default_vpc
    "ap-south-1"     = module.vpc_baseline_ap-south-1.default_vpc
    "ap-southeast-1" = module.vpc_baseline_ap-southeast-1.default_vpc
    "ap-southeast-2" = module.vpc_baseline_ap-southeast-2.default_vpc
    "ca-central-1"   = module.vpc_baseline_ca-central-1.default_vpc
    "eu-central-1"   = module.vpc_baseline_eu-central-1.default_vpc
    "eu-north-1"     = module.vpc_baseline_eu-north-1.default_vpc
    "eu-west-1"      = module.vpc_baseline_eu-west-1.default_vpc
    "eu-west-2"      = module.vpc_baseline_eu-west-2.default_vpc
    "eu-west-3"      = module.vpc_baseline_eu-west-3.default_vpc
    "sa-east-1"      = module.vpc_baseline_sa-east-1.default_vpc
    "us-east-1"      = module.vpc_baseline_us-east-1.default_vpc
    "us-east-2"      = module.vpc_baseline_us-east-2.default_vpc
    "us-west-1"      = module.vpc_baseline_us-west-1.default_vpc
    "us-west-2"      = module.vpc_baseline_us-west-2.default_vpc
  }
}

output "default_security_group" {
  description = "The ID of the default security group."

  value = {
    "ap-northeast-1" = module.vpc_baseline_ap-northeast-1.default_security_group
    "ap-northeast-2" = module.vpc_baseline_ap-northeast-2.default_security_group
    "ap-south-1"     = module.vpc_baseline_ap-south-1.default_security_group
    "ap-southeast-1" = module.vpc_baseline_ap-southeast-1.default_security_group
    "ap-southeast-2" = module.vpc_baseline_ap-southeast-2.default_security_group
    "ca-central-1"   = module.vpc_baseline_ca-central-1.default_security_group
    "eu-central-1"   = module.vpc_baseline_eu-central-1.default_security_group
    "eu-north-1"     = module.vpc_baseline_eu-north-1.default_security_group
    "eu-west-1"      = module.vpc_baseline_eu-west-1.default_security_group
    "eu-west-2"      = module.vpc_baseline_eu-west-2.default_security_group
    "eu-west-3"      = module.vpc_baseline_eu-west-3.default_security_group
    "sa-east-1"      = module.vpc_baseline_sa-east-1.default_security_group
    "us-east-1"      = module.vpc_baseline_us-east-1.default_security_group
    "us-east-2"      = module.vpc_baseline_us-east-2.default_security_group
    "us-west-1"      = module.vpc_baseline_us-west-1.default_security_group
    "us-west-2"      = module.vpc_baseline_us-west-2.default_security_group
  }
}

output "default_network_acl" {
  description = "The default network ACL."

  value = {
    "ap-northeast-1" = module.vpc_baseline_ap-northeast-1.default_network_acl
    "ap-northeast-2" = module.vpc_baseline_ap-northeast-2.default_network_acl
    "ap-south-1"     = module.vpc_baseline_ap-south-1.default_network_acl
    "ap-southeast-1" = module.vpc_baseline_ap-southeast-1.default_network_acl
    "ap-southeast-2" = module.vpc_baseline_ap-southeast-2.default_network_acl
    "ca-central-1"   = module.vpc_baseline_ca-central-1.default_network_acl
    "eu-central-1"   = module.vpc_baseline_eu-central-1.default_network_acl
    "eu-north-1"     = module.vpc_baseline_eu-north-1.default_network_acl
    "eu-west-1"      = module.vpc_baseline_eu-west-1.default_network_acl
    "eu-west-2"      = module.vpc_baseline_eu-west-2.default_network_acl
    "eu-west-3"      = module.vpc_baseline_eu-west-3.default_network_acl
    "sa-east-1"      = module.vpc_baseline_sa-east-1.default_network_acl
    "us-east-1"      = module.vpc_baseline_us-east-1.default_network_acl
    "us-east-2"      = module.vpc_baseline_us-east-2.default_network_acl
    "us-west-1"      = module.vpc_baseline_us-west-1.default_network_acl
    "us-west-2"      = module.vpc_baseline_us-west-2.default_network_acl
  }
}

output "default_route_table" {
  description = "The default route table."

  value = {
    "ap-northeast-1" = module.vpc_baseline_ap-northeast-1.default_route_table
    "ap-northeast-2" = module.vpc_baseline_ap-northeast-2.default_route_table
    "ap-south-1"     = module.vpc_baseline_ap-south-1.default_route_table
    "ap-southeast-1" = module.vpc_baseline_ap-southeast-1.default_route_table
    "ap-southeast-2" = module.vpc_baseline_ap-southeast-2.default_route_table
    "ca-central-1"   = module.vpc_baseline_ca-central-1.default_route_table
    "eu-central-1"   = module.vpc_baseline_eu-central-1.default_route_table
    "eu-north-1"     = module.vpc_baseline_eu-north-1.default_route_table
    "eu-west-1"      = module.vpc_baseline_eu-west-1.default_route_table
    "eu-west-2"      = module.vpc_baseline_eu-west-2.default_route_table
    "eu-west-3"      = module.vpc_baseline_eu-west-3.default_route_table
    "sa-east-1"      = module.vpc_baseline_sa-east-1.default_route_table
    "us-east-1"      = module.vpc_baseline_us-east-1.default_route_table
    "us-east-2"      = module.vpc_baseline_us-east-2.default_route_table
    "us-west-1"      = module.vpc_baseline_us-west-1.default_route_table
    "us-west-2"      = module.vpc_baseline_us-west-2.default_route_table
  }
}

