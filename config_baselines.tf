# --------------------------------------------------------------------------------------------------
# Create an IAM Role for publishing VPC Flow Logs into CloudWatch Logs group.
# Reference: https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/flow-logs.html#flow-logs-iam
# --------------------------------------------------------------------------------------------------

resource "aws_iam_role" "recorder" {
  name = "${var.config_iam_role_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

# See https://docs.aws.amazon.com/config/latest/developerguide/iamrole-permissions.html
data "aws_iam_policy_document" "recoder_publish_policy" {
  statement {
    actions = ["s3:PutObject"]
    resources = ["${module.audit_log_bucket.this_bucket_arn}/config/AWSLogs/${var.aws_account_id}/*"]

    condition {
      test = "StringLike"
      variable = "s3:x-amz-acl"
      values = ["bucket-owner-full-control"]
    }
  }

  statement {
    actions = ["s3:GetBucketAcl"]
    resources = ["${module.audit_log_bucket.this_bucket_arn}"]
  }

  statement {
    actions = ["sns:Publish"]
    resources = [
      "${module.config_baseline_ap-northeast-1.config_topic_arn}",
      "${module.config_baseline_ap-northeast-2.config_topic_arn}",
      "${module.config_baseline_ap-south-1.config_topic_arn}",
      "${module.config_baseline_ap-southeast-1.config_topic_arn}",
      "${module.config_baseline_ap-southeast-2.config_topic_arn}",
      "${module.config_baseline_ca-central-1.config_topic_arn}",
      "${module.config_baseline_eu-central-1.config_topic_arn}",
      "${module.config_baseline_eu-west-1.config_topic_arn}",
      "${module.config_baseline_eu-west-2.config_topic_arn}",
      "${module.config_baseline_eu-west-3.config_topic_arn}",
      "${module.config_baseline_sa-east-1.config_topic_arn}",
      "${module.config_baseline_us-east-1.config_topic_arn}",
      "${module.config_baseline_us-east-2.config_topic_arn}",
      "${module.config_baseline_us-west-1.config_topic_arn}",
      "${module.config_baseline_us-west-2.config_topic_arn}",
    ]
  }
}

resource "aws_iam_role_policy" "recoder_publish_policy" {
  name = "${var.config_iam_role_policy_name}"
  role = "${aws_iam_role.recorder.id}"
  policy = "${data.aws_iam_policy_document.recoder_publish_policy.json}"
}

resource "aws_iam_role_policy_attachment" "recoder_read_policy" {
  role       = "${aws_iam_role.recorder.id}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}

# --------------------------------------------------------------------------------------------------
# Apply VPC baseline for each region.
# --------------------------------------------------------------------------------------------------

module "config_baseline_ap-northeast-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.ap-northeast-1"
  }
}

module "config_baseline_ap-northeast-2" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.ap-northeast-2"
  }
}

module "config_baseline_ap-south-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.ap-south-1"
  }
}

module "config_baseline_ap-southeast-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.ap-southeast-1"
  }
}

module "config_baseline_ap-southeast-2" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.ap-southeast-2"
  }
}

module "config_baseline_ca-central-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.ca-central-1"
  }
}

module "config_baseline_eu-central-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.eu-central-1"
  }
}

module "config_baseline_eu-west-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.eu-west-1"
  }
}

module "config_baseline_eu-west-2" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.eu-west-2"
  }
}

module "config_baseline_eu-west-3" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.eu-west-3"
  }
}

module "config_baseline_sa-east-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.sa-east-1"
  }
}

module "config_baseline_us-east-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.us-east-1"
  }
}

module "config_baseline_us-east-2" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.us-east-2"
  }
}

module "config_baseline_us-west-1" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.us-west-1"
  }
}

module "config_baseline_us-west-2" {
  source             = "./modules/config-baseline"
  iam_role_arn       = "${aws_iam_role.recorder.arn}"
  s3_bucket_name     = "${module.audit_log_bucket.this_bucket_id}"
  s3_key_prefix      = "${var.config_s3_bucket_key_prefix}"
  delivery_frequency = "${var.config_delivery_frequency}"
  sns_topic_name     = "${var.config_sns_topic_name}"

  providers = {
    aws = "aws.us-west-2"
  }
}

# --------------------------------------------------------------------------------------------------
# Global Config Rules
# --------------------------------------------------------------------------------------------------

resource "aws_config_config_rule" "root_mfa" {
  name = "RootAccountMFAEnabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  # Ensure this rule is created after the configuration recorder.
  depends_on = [
    "module.config_baseline_ap-northeast-1",
    "module.config_baseline_ap-northeast-2",
    "module.config_baseline_ap-south-1",
    "module.config_baseline_ap-southeast-1",
    "module.config_baseline_ap-southeast-2",
    "module.config_baseline_ca-central-1",
    "module.config_baseline_eu-central-1",
    "module.config_baseline_eu-west-1",
    "module.config_baseline_eu-west-2",
    "module.config_baseline_eu-west-3",
    "module.config_baseline_sa-east-1",
    "module.config_baseline_us-east-1",
    "module.config_baseline_us-east-2",
    "module.config_baseline_us-west-1",
    "module.config_baseline_us-west-2",
  ]
}
