# --------------------------------------------------------------------------------------------------
# Outputs from the root module.
# --------------------------------------------------------------------------------------------------

output "audit_bucket_arn" {
  description = "The ARN of the S3 bucket used for storing audit logs."
  value       = "${module.audit_log_bucket.this_bucket_arn}"
}

output "audit_bucket_id" {
  description = "The ID of the S3 bucket used for storing audit logs."
  value       = "${module.audit_log_bucket.this_bucket_id}"
}

# --------------------------------------------------------------------------------------------------
# Outputs from alarm-baseline module.
# --------------------------------------------------------------------------------------------------

output "alarms_topic_arn" {
  description = "The ARN of the SNS topic to which CloudWatch Alarms will be sent."
  value       = "${module.alarm_baseline.alarm_topic_arn}"
}

# --------------------------------------------------------------------------------------------------
# Outputs from cloudtrail-baseline module.
# --------------------------------------------------------------------------------------------------

output "cloudtrail_id" {
  description = "The ID of the trail for recording events in all regions."
  value       = "${module.cloudtrail_baseline.cloudtrail_id}"
}

output "cloudtrail_arn" {
  description = "The ARN of the trail for recording events in all regions."
  value       = "${module.cloudtrail_baseline.cloudtrail_arn}"
}

output "cloudtrail_kms_key_arn" {
  description = "The ARN of the KMS key used for encrypting CloudTrail events."
  value       = "${module.cloudtrail_baseline.kms_key_arn}"
}

output "cloudtrail_kms_key_id" {
  description = "The ID of the KMS key used for encrypting CloudTrail events."
  value       = "${module.cloudtrail_baseline.kms_key_id}"
}

output "cloudtrail_log_delivery_iam_role_arn" {
  description = "The ARN of the IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = "${module.cloudtrail_baseline.log_delivery_iam_role_arn}"
}

output "cloudtrail_log_delivery_iam_role_name" {
  description = "The name of the IAM role used for delivering CloudTrail events to CloudWatch Logs."
  value       = "${module.cloudtrail_baseline.log_delivery_iam_role_name}"
}

output "cloudtrail_log_group_arn" {
  description = "The ARN of the CloudWatch Logs log group which stores CloudTrail events."
  value       = "${module.cloudtrail_baseline.log_group_arn}"
}

output "cloudtrail_log_group_name" {
  description = "The name of the CloudWatch Logs log group which stores CloudTrail events."
  value       = "${module.cloudtrail_baseline.log_group_name}"
}

# --------------------------------------------------------------------------------------------------
# Outputs from config-baseline module.
# --------------------------------------------------------------------------------------------------

output "config_iam_role_arn" {
  description = "The ARN of the IAM role used for delivering AWS Config records to CloudWatch Logs."
  value       = "${aws_iam_role.recorder.arn}"
}

output "config_iam_role_name" {
  description = "The name of the IAM role used for delivering AWS Config records to CloudWatch Logs."
  value       = "${aws_iam_role.recorder.name}"
}

output "config_configuration_recorder_id" {
  description = "The name of the configuration recorder."

  value = "${
    map(
      "ap-northeast-1", "${module.config_baseline_ap-northeast-1.configuration_recorder_id}",
      "ap-northeast-2", "${module.config_baseline_ap-northeast-2.configuration_recorder_id}",
      "ap-south-1", "${module.config_baseline_ap-south-1.configuration_recorder_id}",
      "ap-southeast-1", "${module.config_baseline_ap-southeast-1.configuration_recorder_id}",
      "ap-southeast-2", "${module.config_baseline_ap-southeast-2.configuration_recorder_id}",
      "ca-central-1", "${module.config_baseline_ca-central-1.configuration_recorder_id}",
      "eu-central-1", "${module.config_baseline_eu-central-1.configuration_recorder_id}",
      "eu-west-1", "${module.config_baseline_eu-west-1.configuration_recorder_id}",
      "eu-west-2", "${module.config_baseline_eu-west-2.configuration_recorder_id}",
      "eu-west-3", "${module.config_baseline_eu-west-3.configuration_recorder_id}",
      "sa-east-1", "${module.config_baseline_sa-east-1.configuration_recorder_id}",
      "us-east-1", "${module.config_baseline_us-east-1.configuration_recorder_id}",
      "us-east-2", "${module.config_baseline_us-east-2.configuration_recorder_id}",
      "us-west-1", "${module.config_baseline_us-west-1.configuration_recorder_id}",
      "us-west-2", "${module.config_baseline_us-west-2.configuration_recorder_id}",
    )
  }"
}

output "config_topic_arn" {
  description = "The ARN of the SNS topic that AWS Config delivers notifications to."

  value = "${
    map(
      "ap-northeast-1", "${module.config_baseline_ap-northeast-1.config_topic_arn}",
      "ap-northeast-2", "${module.config_baseline_ap-northeast-2.config_topic_arn}",
      "ap-south-1", "${module.config_baseline_ap-south-1.config_topic_arn}",
      "ap-southeast-1", "${module.config_baseline_ap-southeast-1.config_topic_arn}",
      "ap-southeast-2", "${module.config_baseline_ap-southeast-2.config_topic_arn}",
      "ca-central-1", "${module.config_baseline_ca-central-1.config_topic_arn}",
      "eu-central-1", "${module.config_baseline_eu-central-1.config_topic_arn}",
      "eu-west-1", "${module.config_baseline_eu-west-1.config_topic_arn}",
      "eu-west-2", "${module.config_baseline_eu-west-2.config_topic_arn}",
      "eu-west-3", "${module.config_baseline_eu-west-3.config_topic_arn}",
      "sa-east-1", "${module.config_baseline_sa-east-1.config_topic_arn}",
      "us-east-1", "${module.config_baseline_us-east-1.config_topic_arn}",
      "us-east-2", "${module.config_baseline_us-east-2.config_topic_arn}",
      "us-west-1", "${module.config_baseline_us-west-1.config_topic_arn}",
      "us-west-2", "${module.config_baseline_us-west-2.config_topic_arn}",
    )
  }"
}

# --------------------------------------------------------------------------------------------------
# Outputs from guardduty-baseline module.
# --------------------------------------------------------------------------------------------------

output "guardduty_detector_id" {
  description = "The ID of the GuardDuty detector."

  value = "${
    map(
      "ap-northeast-1", "${module.guardduty_baseline_ap-northeast-1.guardduty_detector_id}",
      "ap-northeast-2", "${module.guardduty_baseline_ap-northeast-2.guardduty_detector_id}",
      "ap-south-1", "${module.guardduty_baseline_ap-south-1.guardduty_detector_id}",
      "ap-southeast-1", "${module.guardduty_baseline_ap-southeast-1.guardduty_detector_id}",
      "ap-southeast-2", "${module.guardduty_baseline_ap-southeast-2.guardduty_detector_id}",
      "ca-central-1", "${module.guardduty_baseline_ca-central-1.guardduty_detector_id}",
      "eu-central-1", "${module.guardduty_baseline_eu-central-1.guardduty_detector_id}",
      "eu-west-1", "${module.guardduty_baseline_eu-west-1.guardduty_detector_id}",
      "eu-west-2", "${module.guardduty_baseline_eu-west-2.guardduty_detector_id}",
      "eu-west-3", "${module.guardduty_baseline_eu-west-3.guardduty_detector_id}",
      "sa-east-1", "${module.guardduty_baseline_sa-east-1.guardduty_detector_id}",
      "us-east-1", "${module.guardduty_baseline_us-east-1.guardduty_detector_id}",
      "us-east-2", "${module.guardduty_baseline_us-east-2.guardduty_detector_id}",
      "us-west-1", "${module.guardduty_baseline_us-west-1.guardduty_detector_id}",
      "us-west-2", "${module.guardduty_baseline_us-west-2.guardduty_detector_id}",
    )
  }"
}

# --------------------------------------------------------------------------------------------------
# Outputs from iam-baseline module.
# --------------------------------------------------------------------------------------------------

output "master_iam_role_arn" {
  description = "The ARN of the IAM role used for the master user."
  value       = "${module.iam_baseline.master_iam_role_arn}"
}

output "master_iam_role_name" {
  description = "The name of the IAM role used for the master user."
  value       = "${module.iam_baseline.master_iam_role_name}"
}

output "manager_iam_role_arn" {
  description = "The ARN of the IAM role used for the manager user."
  value       = "${module.iam_baseline.manager_iam_role_arn}"
}

output "manager_iam_role_name" {
  description = "The name of the IAM role used for the manager user."
  value       = "${module.iam_baseline.manager_iam_role_name}"
}

output "support_iam_role_arn" {
  description = "The ARN of the IAM role used for the support user."
  value       = "${module.iam_baseline.support_iam_role_arn}"
}

output "support_iam_role_name" {
  description = "The name of the IAM role used for the support user."
  value       = "${module.iam_baseline.support_iam_role_name}"
}

# --------------------------------------------------------------------------------------------------
# Outputs from vpc-baseline module.
# --------------------------------------------------------------------------------------------------

output "vpc_flow_logs_iam_role_arn" {
  description = "The ARN of the IAM role used for delivering VPC Flow Logs to CloudWatch Logs."
  value       = "${aws_iam_role.vpc_flow_logs_publisher.arn}"
}

output "vpc_flow_logs_iam_role_name" {
  description = "The name of the IAM role used for delivering VPC Flow Logs to CloudWatch Logs."
  value       = "${aws_iam_role.vpc_flow_logs_publisher.name}"
}

output "vpc_flow_logs_group_arn" {
  description = "The ARN of the CloudWatch Logs log group which stores VPC Flow Logs."
  value       = "${aws_cloudwatch_log_group.default_vpc_flow_logs.arn}"
}

output "vpc_flow_logs_group_name" {
  description = "The name of the CloudWatch Logs log group which stores VPC Flow Logs."
  value       = "${aws_cloudwatch_log_group.default_vpc_flow_logs.name}"
}

output "default_vpc_id" {
  description = "The ID of the default VPC."

  value = "${
    map(
      "ap-northeast-1", "${module.vpc_baseline_ap-northeast-1.default_vpc_id}",
      "ap-northeast-2", "${module.vpc_baseline_ap-northeast-2.default_vpc_id}",
      "ap-south-1", "${module.vpc_baseline_ap-south-1.default_vpc_id}",
      "ap-southeast-1", "${module.vpc_baseline_ap-southeast-1.default_vpc_id}",
      "ap-southeast-2", "${module.vpc_baseline_ap-southeast-2.default_vpc_id}",
      "ca-central-1", "${module.vpc_baseline_ca-central-1.default_vpc_id}",
      "eu-central-1", "${module.vpc_baseline_eu-central-1.default_vpc_id}",
      "eu-west-1", "${module.vpc_baseline_eu-west-1.default_vpc_id}",
      "eu-west-2", "${module.vpc_baseline_eu-west-2.default_vpc_id}",
      "eu-west-3", "${module.vpc_baseline_eu-west-3.default_vpc_id}",
      "sa-east-1", "${module.vpc_baseline_sa-east-1.default_vpc_id}",
      "us-east-1", "${module.vpc_baseline_us-east-1.default_vpc_id}",
      "us-east-2", "${module.vpc_baseline_us-east-2.default_vpc_id}",
      "us-west-1", "${module.vpc_baseline_us-west-1.default_vpc_id}",
      "us-west-2", "${module.vpc_baseline_us-west-2.default_vpc_id}",
    )
  }"
}

output "default_security_group_id" {
  description = "The ID of the default security group."

  value = "${
    map(
      "ap-northeast-1", "${module.vpc_baseline_ap-northeast-1.default_security_group_id}",
      "ap-northeast-2", "${module.vpc_baseline_ap-northeast-2.default_security_group_id}",
      "ap-south-1", "${module.vpc_baseline_ap-south-1.default_security_group_id}",
      "ap-southeast-1", "${module.vpc_baseline_ap-southeast-1.default_security_group_id}",
      "ap-southeast-2", "${module.vpc_baseline_ap-southeast-2.default_security_group_id}",
      "ca-central-1", "${module.vpc_baseline_ca-central-1.default_security_group_id}",
      "eu-central-1", "${module.vpc_baseline_eu-central-1.default_security_group_id}",
      "eu-west-1", "${module.vpc_baseline_eu-west-1.default_security_group_id}",
      "eu-west-2", "${module.vpc_baseline_eu-west-2.default_security_group_id}",
      "eu-west-3", "${module.vpc_baseline_eu-west-3.default_security_group_id}",
      "sa-east-1", "${module.vpc_baseline_sa-east-1.default_security_group_id}",
      "us-east-1", "${module.vpc_baseline_us-east-1.default_security_group_id}",
      "us-east-2", "${module.vpc_baseline_us-east-2.default_security_group_id}",
      "us-west-1", "${module.vpc_baseline_us-west-1.default_security_group_id}",
      "us-west-2", "${module.vpc_baseline_us-west-2.default_security_group_id}",
    )
  }"
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL."

  value = "${
    map(
      "ap-northeast-1", "${module.vpc_baseline_ap-northeast-1.default_network_acl_id}",
      "ap-northeast-2", "${module.vpc_baseline_ap-northeast-2.default_network_acl_id}",
      "ap-south-1", "${module.vpc_baseline_ap-south-1.default_network_acl_id}",
      "ap-southeast-1", "${module.vpc_baseline_ap-southeast-1.default_network_acl_id}",
      "ap-southeast-2", "${module.vpc_baseline_ap-southeast-2.default_network_acl_id}",
      "ca-central-1", "${module.vpc_baseline_ca-central-1.default_network_acl_id}",
      "eu-central-1", "${module.vpc_baseline_eu-central-1.default_network_acl_id}",
      "eu-west-1", "${module.vpc_baseline_eu-west-1.default_network_acl_id}",
      "eu-west-2", "${module.vpc_baseline_eu-west-2.default_network_acl_id}",
      "eu-west-3", "${module.vpc_baseline_eu-west-3.default_network_acl_id}",
      "sa-east-1", "${module.vpc_baseline_sa-east-1.default_network_acl_id}",
      "us-east-1", "${module.vpc_baseline_us-east-1.default_network_acl_id}",
      "us-east-2", "${module.vpc_baseline_us-east-2.default_network_acl_id}",
      "us-west-1", "${module.vpc_baseline_us-west-1.default_network_acl_id}",
      "us-west-2", "${module.vpc_baseline_us-west-2.default_network_acl_id}",
    )
  }"
}

output "default_route_table_id" {
  description = "The ID of the default route table."

  value = "${
    map(
      "ap-northeast-1", "${module.vpc_baseline_ap-northeast-1.default_route_table_id}",
      "ap-northeast-2", "${module.vpc_baseline_ap-northeast-2.default_route_table_id}",
      "ap-south-1", "${module.vpc_baseline_ap-south-1.default_route_table_id}",
      "ap-southeast-1", "${module.vpc_baseline_ap-southeast-1.default_route_table_id}",
      "ap-southeast-2", "${module.vpc_baseline_ap-southeast-2.default_route_table_id}",
      "ca-central-1", "${module.vpc_baseline_ca-central-1.default_route_table_id}",
      "eu-central-1", "${module.vpc_baseline_eu-central-1.default_route_table_id}",
      "eu-west-1", "${module.vpc_baseline_eu-west-1.default_route_table_id}",
      "eu-west-2", "${module.vpc_baseline_eu-west-2.default_route_table_id}",
      "eu-west-3", "${module.vpc_baseline_eu-west-3.default_route_table_id}",
      "sa-east-1", "${module.vpc_baseline_sa-east-1.default_route_table_id}",
      "us-east-1", "${module.vpc_baseline_us-east-1.default_route_table_id}",
      "us-east-2", "${module.vpc_baseline_us-east-2.default_route_table_id}",
      "us-west-1", "${module.vpc_baseline_us-west-1.default_route_table_id}",
      "us-west-2", "${module.vpc_baseline_us-west-2.default_route_table_id}",
    )
  }"
}
