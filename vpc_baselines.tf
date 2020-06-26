# --------------------------------------------------------------------------------------------------
# Create an IAM Role for publishing VPC Flow Logs into CloudWatch Logs group.
# Reference: https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/flow-logs.html#flow-logs-iam
# --------------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "vpc_flow_logs_publisher_assume_role_policy" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "vpc_flow_logs_publisher" {
  name               = var.vpc_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.vpc_flow_logs_publisher_assume_role_policy.json

  tags = var.tags
}

data "aws_iam_policy_document" "vpc_flow_logs_publish_policy" {
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

resource "aws_iam_role_policy" "vpc_flow_logs_publish_policy" {
  name = var.vpc_iam_role_policy_name
  role = aws_iam_role.vpc_flow_logs_publisher.id

  policy = data.aws_iam_policy_document.vpc_flow_logs_publish_policy.json
}

# --------------------------------------------------------------------------------------------------
# VPC Baseline
# Needs to be set up in each region.
# --------------------------------------------------------------------------------------------------

module "vpc_baseline_ap-east-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-east-1
  }

  enabled                    = contains(var.target_regions, "ap-east-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_ap-northeast-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  enabled                    = contains(var.target_regions, "ap-northeast-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_ap-northeast-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  enabled                    = contains(var.target_regions, "ap-northeast-2")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_ap-south-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  enabled                    = contains(var.target_regions, "ap-south-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_ap-southeast-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  enabled                    = contains(var.target_regions, "ap-southeast-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_ap-southeast-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  enabled                    = contains(var.target_regions, "ap-southeast-2")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_ca-central-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  enabled                    = contains(var.target_regions, "ca-central-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_eu-central-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  enabled                    = contains(var.target_regions, "eu-central-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_eu-north-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-north-1
  }

  enabled                    = contains(var.target_regions, "eu-north-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_eu-west-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  enabled                    = contains(var.target_regions, "eu-west-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_eu-west-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  enabled                    = contains(var.target_regions, "eu-west-2")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_eu-west-3" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  enabled                    = contains(var.target_regions, "eu-west-3")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_sa-east-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  enabled                    = contains(var.target_regions, "sa-east-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_us-east-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-east-1
  }

  enabled                    = contains(var.target_regions, "us-east-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_us-east-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-east-2
  }

  enabled                    = contains(var.target_regions, "us-east-2")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_us-west-1" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-west-1
  }

  enabled                    = contains(var.target_regions, "us-west-1")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}

module "vpc_baseline_us-west-2" {
  source = "./modules/vpc-baseline"

  providers = {
    aws = aws.us-west-2
  }

  enabled                    = contains(var.target_regions, "us-west-2")
  vpc_log_group_name         = var.vpc_log_group_name
  vpc_flow_logs_iam_role_arn = aws_iam_role.vpc_flow_logs_publisher.arn
  vpc_log_retention_in_days  = var.vpc_log_retention_in_days

  tags = var.tags
}
