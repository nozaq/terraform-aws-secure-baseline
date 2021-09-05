# --------------------------------------------------------------------------------------------------
# Macie Baseline
# Needs to be set up in each region.
# This is an extra configuration which is not included in CIS benchmark.
# --------------------------------------------------------------------------------------------------
locals {
  macie_master_account_id = var.master_account_id
  macie_member_accounts   = var.member_accounts
}

module "macie_baseline_ap-northeast-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  enabled                      = contains(var.target_regions, "ap-northeast-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_ap-northeast-2" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  enabled                      = contains(var.target_regions, "ap-northeast-2") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_ap-northeast-3" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.ap-northeast-3
  }

  enabled                      = contains(var.target_regions, "ap-northeast-3") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_ap-south-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  enabled                      = contains(var.target_regions, "ap-south-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_ap-southeast-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  enabled                      = contains(var.target_regions, "ap-southeast-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_ap-southeast-2" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  enabled                      = contains(var.target_regions, "ap-southeast-2") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_ca-central-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  enabled                      = contains(var.target_regions, "ca-central-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_eu-central-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  enabled                      = contains(var.target_regions, "eu-central-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_eu-north-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.eu-north-1
  }

  enabled                      = contains(var.target_regions, "eu-north-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_eu-west-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  enabled                      = contains(var.target_regions, "eu-west-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_eu-west-2" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  enabled                      = contains(var.target_regions, "eu-west-2") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_eu-west-3" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  enabled                      = contains(var.target_regions, "eu-west-3") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_sa-east-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  enabled                      = contains(var.target_regions, "sa-east-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_us-east-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.us-east-1
  }

  enabled                      = contains(var.target_regions, "us-east-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_us-east-2" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.us-east-2
  }

  enabled                      = contains(var.target_regions, "us-east-2") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_us-west-1" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.us-west-1
  }

  enabled                      = contains(var.target_regions, "us-west-1") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}

module "macie_baseline_us-west-2" {
  source = "./modules/macie-baseline"

  providers = {
    aws = aws.us-west-2
  }

  enabled                      = contains(var.target_regions, "us-west-2") && var.macie_enabled
  disable_email_notification   = var.macie_disable_email_notification
  finding_publishing_frequency = var.macie_finding_publishing_frequency
  invitation_message           = var.macie_invitation_message
  master_account_id            = local.macie_master_account_id
  member_accounts              = local.macie_member_accounts

  tags = var.tags
}
