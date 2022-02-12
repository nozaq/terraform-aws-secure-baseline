# --------------------------------------------------------------------------------------------------
# Migrations to 1.0.0
# Replacing `enabled` argument in secure-bucket module with `count` meta-argument
# --------------------------------------------------------------------------------------------------

moved {
  from = module.audit_log_bucket
  to   = module.audit_log_bucket[0]
}

# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Replacing `enabled` argument in each sub-module with `count` meta-argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = module.cloudtrail_baseline
  to   = module.cloudtrail_baseline[0]
}

moved {
  from = module.alarm_baseline
  to   = module.alarm_baseline[0]
}

moved {
  from = module.s3_baseline
  to   = module.s3_baseline[0]
}

moved {
  from = module.iam_baseline
  to   = module.iam_baseline[0]
}

moved {
  from = module.analyzer_baseline
  to   = module.analyzer_baseline[0]
}

# Config baseline
moved {
  from = module.config_baseline_ap-northeast-1
  to   = module.config_baseline_ap-northeast-1[0]
}

moved {
  from = module.config_baseline_ap-northeast-2
  to   = module.config_baseline_ap-northeast-2[0]
}

moved {
  from = module.config_baseline_ap-northeast-3
  to   = module.config_baseline_ap-northeast-3[0]
}

moved {
  from = module.config_baseline_ap-south-1
  to   = module.config_baseline_ap-south-1[0]
}

moved {
  from = module.config_baseline_ap-southeast-1
  to   = module.config_baseline_ap-southeast-1[0]
}

moved {
  from = module.config_baseline_ap-southeast-2
  to   = module.config_baseline_ap-southeast-2[0]
}

moved {
  from = module.config_baseline_ca-central-1
  to   = module.config_baseline_ca-central-1[0]
}

moved {
  from = module.config_baseline_eu-central-1
  to   = module.config_baseline_eu-central-1[0]
}

moved {
  from = module.config_baseline_eu-north-1
  to   = module.config_baseline_eu-north-1[0]
}

moved {
  from = module.config_baseline_eu-west-1
  to   = module.config_baseline_eu-west-1[0]
}

moved {
  from = module.config_baseline_eu-west-2
  to   = module.config_baseline_eu-west-2[0]
}

moved {
  from = module.config_baseline_eu-west-3
  to   = module.config_baseline_eu-west-3[0]
}

moved {
  from = module.config_baseline_sa-east-1
  to   = module.config_baseline_sa-east-1[0]
}

moved {
  from = module.config_baseline_us-east-1
  to   = module.config_baseline_us-east-1[0]
}

moved {
  from = module.config_baseline_us-east-2
  to   = module.config_baseline_us-east-2[0]
}

moved {
  from = module.config_baseline_us-west-1
  to   = module.config_baseline_us-west-1[0]
}

moved {
  from = module.config_baseline_us-west-2
  to   = module.config_baseline_us-west-2[0]
}

# EBS baseline
moved {
  from = module.ebs_baseline_ap-northeast-1
  to   = module.ebs_baseline_ap-northeast-1[0]
}

moved {
  from = module.ebs_baseline_ap-northeast-2
  to   = module.ebs_baseline_ap-northeast-2[0]
}

moved {
  from = module.ebs_baseline_ap-northeast-3
  to   = module.ebs_baseline_ap-northeast-3[0]
}

moved {
  from = module.ebs_baseline_ap-south-1
  to   = module.ebs_baseline_ap-south-1[0]
}

moved {
  from = module.ebs_baseline_ap-southeast-1
  to   = module.ebs_baseline_ap-southeast-1[0]
}

moved {
  from = module.ebs_baseline_ap-southeast-2
  to   = module.ebs_baseline_ap-southeast-2[0]
}

moved {
  from = module.ebs_baseline_ca-central-1
  to   = module.ebs_baseline_ca-central-1[0]
}

moved {
  from = module.ebs_baseline_eu-central-1
  to   = module.ebs_baseline_eu-central-1[0]
}

moved {
  from = module.ebs_baseline_eu-north-1
  to   = module.ebs_baseline_eu-north-1[0]
}

moved {
  from = module.ebs_baseline_eu-west-1
  to   = module.ebs_baseline_eu-west-1[0]
}

moved {
  from = module.ebs_baseline_eu-west-2
  to   = module.ebs_baseline_eu-west-2[0]
}

moved {
  from = module.ebs_baseline_eu-west-3
  to   = module.ebs_baseline_eu-west-3[0]
}

moved {
  from = module.ebs_baseline_sa-east-1
  to   = module.ebs_baseline_sa-east-1[0]
}

moved {
  from = module.ebs_baseline_us-east-1
  to   = module.ebs_baseline_us-east-1[0]
}

moved {
  from = module.ebs_baseline_us-east-2
  to   = module.ebs_baseline_us-east-2[0]
}

moved {
  from = module.ebs_baseline_us-west-1
  to   = module.ebs_baseline_us-west-1[0]
}

moved {
  from = module.ebs_baseline_us-west-2
  to   = module.ebs_baseline_us-west-2[0]
}

# Guardduty baseline
moved {
  from = module.guardduty_baseline_ap-northeast-1
  to   = module.guardduty_baseline_ap-northeast-1[0]
}

moved {
  from = module.guardduty_baseline_ap-northeast-2
  to   = module.guardduty_baseline_ap-northeast-2[0]
}

moved {
  from = module.guardduty_baseline_ap-northeast-3
  to   = module.guardduty_baseline_ap-northeast-3[0]
}

moved {
  from = module.guardduty_baseline_ap-south-1
  to   = module.guardduty_baseline_ap-south-1[0]
}

moved {
  from = module.guardduty_baseline_ap-southeast-1
  to   = module.guardduty_baseline_ap-southeast-1[0]
}

moved {
  from = module.guardduty_baseline_ap-southeast-2
  to   = module.guardduty_baseline_ap-southeast-2[0]
}

moved {
  from = module.guardduty_baseline_ca-central-1
  to   = module.guardduty_baseline_ca-central-1[0]
}

moved {
  from = module.guardduty_baseline_eu-central-1
  to   = module.guardduty_baseline_eu-central-1[0]
}

moved {
  from = module.guardduty_baseline_eu-north-1
  to   = module.guardduty_baseline_eu-north-1[0]
}

moved {
  from = module.guardduty_baseline_eu-west-1
  to   = module.guardduty_baseline_eu-west-1[0]
}

moved {
  from = module.guardduty_baseline_eu-west-2
  to   = module.guardduty_baseline_eu-west-2[0]
}

moved {
  from = module.guardduty_baseline_eu-west-3
  to   = module.guardduty_baseline_eu-west-3[0]
}

moved {
  from = module.guardduty_baseline_sa-east-1
  to   = module.guardduty_baseline_sa-east-1[0]
}

moved {
  from = module.guardduty_baseline_us-east-1
  to   = module.guardduty_baseline_us-east-1[0]
}

moved {
  from = module.guardduty_baseline_us-east-2
  to   = module.guardduty_baseline_us-east-2[0]
}

moved {
  from = module.guardduty_baseline_us-west-1
  to   = module.guardduty_baseline_us-west-1[0]
}

moved {
  from = module.guardduty_baseline_us-west-2
  to   = module.guardduty_baseline_us-west-2[0]
}

# SecurityHub baseline
moved {
  from = module.securityhub_baseline_ap-northeast-1
  to   = module.securityhub_baseline_ap-northeast-1[0]
}

moved {
  from = module.securityhub_baseline_ap-northeast-2
  to   = module.securityhub_baseline_ap-northeast-2[0]
}

moved {
  from = module.securityhub_baseline_ap-northeast-3
  to   = module.securityhub_baseline_ap-northeast-3[0]
}

moved {
  from = module.securityhub_baseline_ap-south-1
  to   = module.securityhub_baseline_ap-south-1[0]
}

moved {
  from = module.securityhub_baseline_ap-southeast-1
  to   = module.securityhub_baseline_ap-southeast-1[0]
}

moved {
  from = module.securityhub_baseline_ap-southeast-2
  to   = module.securityhub_baseline_ap-southeast-2[0]
}

moved {
  from = module.securityhub_baseline_ca-central-1
  to   = module.securityhub_baseline_ca-central-1[0]
}

moved {
  from = module.securityhub_baseline_eu-central-1
  to   = module.securityhub_baseline_eu-central-1[0]
}

moved {
  from = module.securityhub_baseline_eu-north-1
  to   = module.securityhub_baseline_eu-north-1[0]
}

moved {
  from = module.securityhub_baseline_eu-west-1
  to   = module.securityhub_baseline_eu-west-1[0]
}

moved {
  from = module.securityhub_baseline_eu-west-2
  to   = module.securityhub_baseline_eu-west-2[0]
}

moved {
  from = module.securityhub_baseline_eu-west-3
  to   = module.securityhub_baseline_eu-west-3[0]
}

moved {
  from = module.securityhub_baseline_sa-east-1
  to   = module.securityhub_baseline_sa-east-1[0]
}

moved {
  from = module.securityhub_baseline_us-east-1
  to   = module.securityhub_baseline_us-east-1[0]
}

moved {
  from = module.securityhub_baseline_us-east-2
  to   = module.securityhub_baseline_us-east-2[0]
}

moved {
  from = module.securityhub_baseline_us-west-1
  to   = module.securityhub_baseline_us-west-1[0]
}

moved {
  from = module.securityhub_baseline_us-west-2
  to   = module.securityhub_baseline_us-west-2[0]
}

# vpc baseline
moved {
  from = module.vpc_baseline_ap-northeast-1
  to   = module.vpc_baseline_ap-northeast-1[0]
}

moved {
  from = module.vpc_baseline_ap-northeast-2
  to   = module.vpc_baseline_ap-northeast-2[0]
}

moved {
  from = module.vpc_baseline_ap-northeast-3
  to   = module.vpc_baseline_ap-northeast-3[0]
}

moved {
  from = module.vpc_baseline_ap-south-1
  to   = module.vpc_baseline_ap-south-1[0]
}

moved {
  from = module.vpc_baseline_ap-southeast-1
  to   = module.vpc_baseline_ap-southeast-1[0]
}

moved {
  from = module.vpc_baseline_ap-southeast-2
  to   = module.vpc_baseline_ap-southeast-2[0]
}

moved {
  from = module.vpc_baseline_ca-central-1
  to   = module.vpc_baseline_ca-central-1[0]
}

moved {
  from = module.vpc_baseline_eu-central-1
  to   = module.vpc_baseline_eu-central-1[0]
}

moved {
  from = module.vpc_baseline_eu-north-1
  to   = module.vpc_baseline_eu-north-1[0]
}

moved {
  from = module.vpc_baseline_eu-west-1
  to   = module.vpc_baseline_eu-west-1[0]
}

moved {
  from = module.vpc_baseline_eu-west-2
  to   = module.vpc_baseline_eu-west-2[0]
}

moved {
  from = module.vpc_baseline_eu-west-3
  to   = module.vpc_baseline_eu-west-3[0]
}

moved {
  from = module.vpc_baseline_sa-east-1
  to   = module.vpc_baseline_sa-east-1[0]
}

moved {
  from = module.vpc_baseline_us-east-1
  to   = module.vpc_baseline_us-east-1[0]
}

moved {
  from = module.vpc_baseline_us-east-2
  to   = module.vpc_baseline_us-east-2[0]
}

moved {
  from = module.vpc_baseline_us-west-1
  to   = module.vpc_baseline_us-west-1[0]
}

moved {
  from = module.vpc_baseline_us-west-2
  to   = module.vpc_baseline_us-west-2[0]
}

# analyzer baseline
moved {
  from = module.analyzer_baseline_ap-northeast-1
  to   = module.analyzer_baseline_ap-northeast-1[0]
}

moved {
  from = module.analyzer_baseline_ap-northeast-2
  to   = module.analyzer_baseline_ap-northeast-2[0]
}

moved {
  from = module.analyzer_baseline_ap-northeast-3
  to   = module.analyzer_baseline_ap-northeast-3[0]
}

moved {
  from = module.analyzer_baseline_ap-south-1
  to   = module.analyzer_baseline_ap-south-1[0]
}

moved {
  from = module.analyzer_baseline_ap-southeast-1
  to   = module.analyzer_baseline_ap-southeast-1[0]
}

moved {
  from = module.analyzer_baseline_ap-southeast-2
  to   = module.analyzer_baseline_ap-southeast-2[0]
}

moved {
  from = module.analyzer_baseline_ca-central-1
  to   = module.analyzer_baseline_ca-central-1[0]
}

moved {
  from = module.analyzer_baseline_eu-central-1
  to   = module.analyzer_baseline_eu-central-1[0]
}

moved {
  from = module.analyzer_baseline_eu-north-1
  to   = module.analyzer_baseline_eu-north-1[0]
}

moved {
  from = module.analyzer_baseline_eu-west-1
  to   = module.analyzer_baseline_eu-west-1[0]
}

moved {
  from = module.analyzer_baseline_eu-west-2
  to   = module.analyzer_baseline_eu-west-2[0]
}

moved {
  from = module.analyzer_baseline_eu-west-3
  to   = module.analyzer_baseline_eu-west-3[0]
}

moved {
  from = module.analyzer_baseline_sa-east-1
  to   = module.analyzer_baseline_sa-east-1[0]
}

moved {
  from = module.analyzer_baseline_us-east-1
  to   = module.analyzer_baseline_us-east-1[0]
}

moved {
  from = module.analyzer_baseline_us-east-2
  to   = module.analyzer_baseline_us-east-2[0]
}

moved {
  from = module.analyzer_baseline_us-west-1
  to   = module.analyzer_baseline_us-west-1[0]
}

moved {
  from = module.analyzer_baseline_us-west-2
  to   = module.analyzer_baseline_us-west-2[0]
}
