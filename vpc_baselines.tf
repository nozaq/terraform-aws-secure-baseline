locals {
  is_cw_logs = var.vpc_flow_logs_destination_type == "cloud-watch-logs"
  is_s3      = var.vpc_flow_logs_destination_type == "s3"
  flow_logs_s3_arn = local.is_s3 ? (
    var.vpc_flow_logs_s3_arn != "" ? var.vpc_flow_logs_s3_arn : local.audit_log_bucket_arn
  ) : ""
}

# --------------------------------------------------------------------------------------------------
# Create an IAM Role for publishing VPC Flow Logs into CloudWatch Logs group.
# Reference: https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/flow-logs.html#flow-logs-iam
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "flow_logs_publisher_assume_role_policy" {
  count = var.vpc_enable_flow_logs && local.is_cw_logs ? 1 : 0

  statement {
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "flow_logs_publisher" {
  count = var.vpc_enable_flow_logs && local.is_cw_logs ? 1 : 0

  name               = var.vpc_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.flow_logs_publisher_assume_role_policy[0].json

  tags = var.tags
}

data "aws_iam_policy_document" "flow_logs_publish_policy" {
  count = var.vpc_enable_flow_logs && local.is_cw_logs ? 1 : 0

  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "flow_logs_publish_policy" {
  count = var.vpc_enable_flow_logs && local.is_cw_logs ? 1 : 0

  name = var.vpc_iam_role_policy_name
  role = aws_iam_role.flow_logs_publisher[0].id

  policy = data.aws_iam_policy_document.flow_logs_publish_policy[0].json
}

# --------------------------------------------------------------------------------------------------
# VPC Baseline
# Needs to be set up in each region.
# --------------------------------------------------------------------------------------------------

module "vpc_baseline_ap-northeast-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  enabled                     = contains(var.target_regions, "ap-northeast-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_ap-northeast-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  enabled                     = contains(var.target_regions, "ap-northeast-2")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_ap-south-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  enabled                     = contains(var.target_regions, "ap-south-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_ap-southeast-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  enabled                     = contains(var.target_regions, "ap-southeast-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_ap-southeast-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  enabled                     = contains(var.target_regions, "ap-southeast-2")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_ca-central-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  enabled                     = contains(var.target_regions, "ca-central-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_eu-central-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  enabled                     = contains(var.target_regions, "eu-central-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_eu-north-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-north-1
  }

  enabled                     = contains(var.target_regions, "eu-north-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_eu-west-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  enabled                     = contains(var.target_regions, "eu-west-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_eu-west-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  enabled                     = contains(var.target_regions, "eu-west-2")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_eu-west-3" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  enabled                     = contains(var.target_regions, "eu-west-3")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_sa-east-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  enabled                     = contains(var.target_regions, "sa-east-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_us-east-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-east-1
  }

  enabled                     = contains(var.target_regions, "us-east-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_us-east-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-east-2
  }

  enabled                     = contains(var.target_regions, "us-east-2")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_us-west-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-west-1
  }

  enabled                     = contains(var.target_regions, "us-west-1")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}

module "vpc_baseline_us-west-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-west-2
  }

  enabled                     = contains(var.target_regions, "us-west-2")
  enable_flow_logs            = var.vpc_enable_flow_logs
  flow_logs_destination_type  = var.vpc_flow_logs_destination_type
  flow_logs_log_group_name    = var.vpc_flow_logs_log_group_name
  flow_logs_iam_role_arn      = local.is_cw_logs ? aws_iam_role.flow_logs_publisher[0].arn : null
  flow_logs_retention_in_days = var.vpc_flow_logs_retention_in_days
  flow_logs_s3_arn            = local.flow_logs_s3_arn
  flow_logs_s3_key_prefix     = var.vpc_flow_logs_s3_key_prefix


  tags = var.tags
}
