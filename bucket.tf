# --------------------------------------------------------------------------------------------------
# Configure the S3 bucket to store audit logs.
# --------------------------------------------------------------------------------------------------
locals {
  use_external_bucket  = var.use_external_audit_log_bucket
  audit_log_bucket_id  = local.use_external_bucket ? data.aws_s3_bucket.external[0].id : module.audit_log_bucket.this_bucket.id
  audit_log_bucket_arn = local.use_external_bucket ? data.aws_s3_bucket.external[0].arn : module.audit_log_bucket.this_bucket.arn
}

# --------------------------------------------------------------------------------------------------
# Case 1. Use the external S3 bucket.
# --------------------------------------------------------------------------------------------------
data "aws_s3_bucket" "external" {
  count  = local.use_external_bucket ? 1 : 0
  bucket = var.audit_log_bucket_name
}

# --------------------------------------------------------------------------------------------------
# Case 2. Create a new S3 bucket.
#
# Create a S3 bucket to store various audit logs.
# Bucket policies are derived from the default bucket policy described in
# AWS Config Developer Guide and AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/config/latest/developerguide/s3-bucket-policy.html
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html
# --------------------------------------------------------------------------------------------------
module "audit_log_bucket" {
  source = "./modules/secure-bucket"

  bucket_name                       = var.audit_log_bucket_name
  log_bucket_name                   = "${var.audit_log_bucket_name}-access-logs"
  lifecycle_glacier_transition_days = var.audit_log_lifecycle_glacier_transition_days
  force_destroy                     = var.audit_log_bucket_force_destroy
  enabled                           = ! local.use_external_bucket
}

resource "aws_s3_bucket_policy" "audit_log" {
  count = local.use_external_bucket ? 0 : 1

  bucket = module.audit_log_bucket.this_bucket.id
  policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailAclCheckForConfig",
      "Effect": "Allow",
      "Principal": {"Service": "config.amazonaws.com"},
      "Action": "s3:GetBucketAcl",
      "Resource": "${module.audit_log_bucket.this_bucket.arn}"
    },
    {
      "Sid": " AWSCloudTrailWriteForConfig",
      "Effect": "Allow",
      "Principal": {"Service": "config.amazonaws.com"},
      "Action": "s3:PutObject",
      "Resource": "${module.audit_log_bucket.this_bucket.arn}/config/AWSLogs/${var.aws_account_id}/Config/*",
      "Condition": {"StringEquals": {"s3:x-amz-acl": "bucket-owner-full-control"}}
    },
    {
        "Sid": "AWSCloudTrailAclCheckForCloudTrail",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:GetBucketAcl",
        "Resource": "${module.audit_log_bucket.this_bucket.arn}"
    },
    {
        "Sid": "AWSCloudTrailWriteForCloudTrail",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudtrail.amazonaws.com"
        },
        "Action": "s3:PutObject",
        "Resource": "${module.audit_log_bucket.this_bucket.arn}/cloudtrail/AWSLogs/${var.aws_account_id}/*",
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
