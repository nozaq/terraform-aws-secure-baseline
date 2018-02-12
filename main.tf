# --------------------------------------------------------------------------------------------------
# Create a S3 bucket to store various audit logs.
# Bucket policies are derived from the default bucket policy described in
# AWS Config Developer Guide and AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
# --------------------------------------------------------------------------------------------------

module "audit_log_bucket" {
  source = "./modules/secure-bucket"

  bucket_name     = "${var.audit_log_bucket_name}"
  log_bucket_name = "${var.audit_log_bucket_name}-access-logs"
}

resource "aws_s3_bucket_policy" "audit_log_bucket_policy" {
  bucket = "${module.audit_log_bucket.bucket_id}"

  policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailAclCheckForConfig",
      "Effect": "Allow",
      "Principal": {"Service": "config.amazonaws.com"},
      "Action": "s3:GetBucketAcl",
      "Resource": "${module.audit_log_bucket.bucket_arn}"
    },
    {
      "Sid": " AWSCloudTrailWriteForConfig",
      "Effect": "Allow",
      "Principal": {"Service": "config.amazonaws.com"},
      "Action": "s3:PutObject",
      "Resource": "${module.audit_log_bucket.bucket_arn}/config/AWSLogs/${var.aws_account_id}/Config/*",
      "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
    },
    {
        "Sid": "AWSCloudTrailAclCheckForCloudTrail",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "${module.audit_log_bucket.bucket_arn}"
    },
    {
        "Sid": "AWSCloudTrailWriteForCloudTrail",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:PutObject",
        "Resource": "${module.audit_log_bucket.bucket_arn}/cloudtrail/AWSLogs/${var.aws_account_id}/*",
        "Condition": {
            "StringEquals": {
                "s3:x-amz-acl": "bucket-owner-full-control"
            }
        }
    }
  ]
}
END_OF_POLICY
}

# --------------------------------------------------------------------------------------------------
# IAM Password Policy
# --------------------------------------------------------------------------------------------------

resource "aws_iam_account_password_policy" "cis" {
  minimum_password_length        = 14
  password_reuse_prevention      = 24
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
}

# --------------------------------------------------------------------------------------------------
# CloudTrail Baseline
# --------------------------------------------------------------------------------------------------

module "cloudtrail_baseline" {
  source = "./modules/cloudtrail-baseline"

  aws_account_id              = "${var.aws_account_id}"
  cloudtrail_name             = "${var.cloudtrail_name}"
  cloudwatch_logs_group_name  = "${var.cloudtrail_cloudwatch_logs_group_name}"
  iam_role_name               = "${var.cloudtrail_iam_role_name}"
  iam_role_policy_name        = "${var.cloudtrail_iam_role_policy_name}"
  key_deletion_window_in_days = "${var.cloudtrail_key_deletion_window_in_days}"
  region                      = "${var.region}"
  s3_bucket_name              = "${module.audit_log_bucket.bucket_id}"
  s3_key_prefix               = "${var.cloudtrail_s3_key_prefix}"
}

# --------------------------------------------------------------------------------------------------
# CloudWatch Alarms Baseline
# --------------------------------------------------------------------------------------------------

module "alarm_baseline" {
  source = "./modules/alarm-baseline"

  alarm_namespace           = "${var.alarm_namespace}"
  cloudtrail_log_group_name = "${module.cloudtrail_baseline.log_group_name}"
  sns_topic_name            = "${var.alarm_sns_topic_name}"
}
