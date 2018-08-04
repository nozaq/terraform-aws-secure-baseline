# --------------------------------------------------------------------------------------------------
# CloudWatch Logs group to accept CloudTrail event stream.
# --------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "cloudtrail_events" {
  name              = "${var.cloudwatch_logs_group_name}"
  retention_in_days = "${var.cloudwatch_logs_retention_in_days}"
}

# --------------------------------------------------------------------------------------------------
# IAM Role to deliver CloudTrail events to CloudWatch Logs group.
# The policy was derived from the default key policy descrived in AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/send-cloudtrail-events-to-cloudwatch-logs.html
# --------------------------------------------------------------------------------------------------

resource "aws_iam_role" "cloudwatch_delivery" {
  name = "${var.iam_role_name}"

  assume_role_policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "cloudtrail.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
END_OF_POLICY
}

resource "aws_iam_role_policy" "cloudwatch_delivery_policy" {
  name = "${var.iam_role_policy_name}"

  role = "${aws_iam_role.cloudwatch_delivery.id}"

  policy = <<END_OF_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AWSCloudTrailCreateLogStream2014110",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogStream"
      ],
      "Resource": [
        "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail_events.name}:log-stream:*"
      ]

    },
    {
      "Sid": "AWSCloudTrailPutLogEvents20141101",
      "Effect": "Allow",
      "Action": [
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:${var.region}:${var.aws_account_id}:log-group:${aws_cloudwatch_log_group.cloudtrail_events.name}:log-stream:*"
      ]
    }
  ]
}
END_OF_POLICY
}

# --------------------------------------------------------------------------------------------------
# KMS Key to encrypt CloudTrail events.
# The policy was derived from the default key policy descrived in AWS CloudTrail User Guide.
# https://docs.aws.amazon.com/awscloudtrail/latest/userguide/default-cmk-policy.html
# --------------------------------------------------------------------------------------------------

resource "aws_kms_key" "cloudtrail" {
  description             = "A KMS key to encrypt CloudTrail events."
  deletion_window_in_days = "${var.key_deletion_window_in_days}"
  enable_key_rotation     = "true"

  policy = <<END_OF_POLICY
{
    "Version": "2012-10-17",
    "Id": "Key policy created by CloudTrail",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {"AWS": [
                "arn:aws:iam::${var.aws_account_id}:root"
            ]},
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow CloudTrail to encrypt logs",
            "Effect": "Allow",
            "Principal": {"Service": ["cloudtrail.amazonaws.com"]},
            "Action": "kms:GenerateDataKey*",
            "Resource": "*",
            "Condition": {"StringLike": {"kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${var.aws_account_id}:trail/*"}}
        },
        {
            "Sid": "Allow CloudTrail to describe key",
            "Effect": "Allow",
            "Principal": {"Service": ["cloudtrail.amazonaws.com"]},
            "Action": "kms:DescribeKey",
            "Resource": "*"
        },
        {
            "Sid": "Allow principals in the account to decrypt log files",
            "Effect": "Allow",
            "Principal": {"AWS": "*"},
            "Action": [
                "kms:Decrypt",
                "kms:ReEncryptFrom"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {"kms:CallerAccount": "${var.aws_account_id}"},
                "StringLike": {"kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${var.aws_account_id}:trail/*"}
            }
        },
        {
            "Sid": "Allow alias creation during setup",
            "Effect": "Allow",
            "Principal": {"AWS": "*"},
            "Action": "kms:CreateAlias",
            "Resource": "*",
            "Condition": {"StringEquals": {
                "kms:ViaService": "ec2.${var.region}.amazonaws.com",
                "kms:CallerAccount": "${var.aws_account_id}"
            }}
        },
        {
            "Sid": "Enable cross account log decryption",
            "Effect": "Allow",
            "Principal": {"AWS": "*"},
            "Action": [
                "kms:Decrypt",
                "kms:ReEncryptFrom"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {"kms:CallerAccount": "${var.aws_account_id}"},
                "StringLike": {"kms:EncryptionContext:aws:cloudtrail:arn": "arn:aws:cloudtrail:*:${var.aws_account_id}:trail/*"}
            }
        }
    ]
}
END_OF_POLICY
}

# --------------------------------------------------------------------------------------------------
# CloudTrail configuration.
# --------------------------------------------------------------------------------------------------

resource "aws_cloudtrail" "global" {
  name = "${var.cloudtrail_name}"

  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail_events.arn}"
  cloud_watch_logs_role_arn     = "${aws_iam_role.cloudwatch_delivery.arn}"
  enable_log_file_validation    = true
  include_global_service_events = true
  is_multi_region_trail         = true
  kms_key_id                    = "${aws_kms_key.cloudtrail.arn}"
  s3_bucket_name                = "${var.s3_bucket_name}"
  s3_key_prefix                 = "${var.s3_key_prefix}"
}
