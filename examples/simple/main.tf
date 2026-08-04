terraform {
  required_version = ">= 1.1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.3"
    }
  }
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {
}

resource "aws_iam_user" "admin" {
  name = "admin"
}

module "secure_baseline" {
  # Option 1: Using HTTPS
  source = "git::https://github.com/YOUR_USERNAME/terraform-aws-secure-baseline.git"
  
  # Option 2: Using SSH
  # source = "git::ssh://git@github.com/YOUR_USERNAME/terraform-aws-secure-baseline.git"
  
  # Option 3: Using a specific branch
  # source = "git::https://github.com/YOUR_USERNAME/terraform-aws-secure-baseline.git?ref=feature-branch"
  
  # Option 4: Using a specific tag
  # source = "git::https://github.com/YOUR_USERNAME/terraform-aws-secure-baseline.git?ref=v1.0.0"
  
  # Option 5: Using a specific commit
  # source = "git::https://github.com/YOUR_USERNAME/terraform-aws-secure-baseline.git?ref=abcd1234"

  audit_log_bucket_name           = var.audit_s3_bucket_name
  aws_account_id                  = data.aws_caller_identity.current.account_id
  region                          = var.region
  support_iam_role_principal_arns = [aws_iam_user.admin.arn]

  # Setting it to true means all audit logs are automatically deleted
  #   when you run `terraform destroy`.
  # Note that it might be inappropriate for highly secured environment.
  audit_log_bucket_force_destroy = true

  providers = {
    aws                = aws
    aws.ap-northeast-1 = aws.ap-northeast-1
    aws.ap-northeast-2 = aws.ap-northeast-2
    aws.ap-northeast-3 = aws.ap-northeast-3
    aws.ap-south-1     = aws.ap-south-1
    aws.ap-southeast-1 = aws.ap-southeast-1
    aws.ap-southeast-2 = aws.ap-southeast-2
    aws.ca-central-1   = aws.ca-central-1
    aws.eu-central-1   = aws.eu-central-1
    aws.eu-north-1     = aws.eu-north-1
    aws.eu-west-1      = aws.eu-west-1
    aws.eu-west-2      = aws.eu-west-2
    aws.eu-west-3      = aws.eu-west-3
    aws.il-central-1   = aws.il-central-1
    aws.me-central-1   = aws.me-central-1
    aws.sa-east-1      = aws.sa-east-1
    aws.us-east-1      = aws.us-east-1
    aws.us-east-2      = aws.us-east-2
    aws.us-west-1      = aws.us-west-1
    aws.us-west-2      = aws.us-west-2
  }
}

