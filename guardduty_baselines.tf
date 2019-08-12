# --------------------------------------------------------------------------------------------------
# GuardDuty Baseline
# Needs to be set up in each region.
# This is an extra configuration which is not included in CIS benchmark.
# --------------------------------------------------------------------------------------------------
locals {
  guardduty_master_account_id = length(var.guardduty_master_account_id) > 0 ? var.guardduty_master_account_id : var.master_account_id
}

module "guardduty_baseline_ap-northeast-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_ap-northeast-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_ap-south-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_ap-southeast-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_ap-southeast-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_ca-central-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_eu-central-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_eu-north-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.eu-north-1"
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_eu-west-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_eu-west-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_eu-west-3" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_sa-east-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_us-east-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.us-east-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_us-east-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.us-east-2
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_us-west-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.us-west-1
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}

module "guardduty_baseline_us-west-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = aws.us-west-2
  }

  finding_publishing_frequency = var.guardduty_finding_publishing_frequency
  master_account_id            = local.guardduty_master_account_id
  member_accounts              = var.guardduty_member_accounts
}
