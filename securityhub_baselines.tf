# --------------------------------------------------------------------------------------------------
# SecurityHub Baseline
# --------------------------------------------------------------------------------------------------

locals {
  securityhub_master_account_id = var.master_account_id
  securityhub_member_accounts   = var.member_accounts
}

module "securityhub_baseline_ap-northeast-1" {
  count  = contains(var.target_regions, "ap-northeast-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  aggregate_findings               = var.region == "ap-northeast-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_ap-northeast-2" {
  count  = contains(var.target_regions, "ap-northeast-2") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  aggregate_findings               = var.region == "ap-northeast-2"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_ap-northeast-3" {
  count  = contains(var.target_regions, "ap-northeast-3") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.ap-northeast-3
  }

  aggregate_findings               = var.region == "ap-northeast-3"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_ap-south-1" {
  count  = contains(var.target_regions, "ap-south-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  aggregate_findings               = var.region == "ap-south-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_ap-southeast-1" {
  count  = contains(var.target_regions, "ap-southeast-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  aggregate_findings               = var.region == "ap-southeast-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_ap-southeast-2" {
  count  = contains(var.target_regions, "ap-southeast-2") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  aggregate_findings               = var.region == "ap-southeast-2"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_ca-central-1" {
  count  = contains(var.target_regions, "ca-central-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  aggregate_findings               = var.region == "ca-central-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_eu-central-1" {
  count  = contains(var.target_regions, "eu-central-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  aggregate_findings               = var.region == "eu-central-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_eu-north-1" {
  count  = contains(var.target_regions, "eu-north-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.eu-north-1
  }

  aggregate_findings               = var.region == "eu-north-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_eu-west-1" {
  count  = contains(var.target_regions, "eu-west-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  aggregate_findings               = var.region == "eu-west-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_eu-west-2" {
  count  = contains(var.target_regions, "eu-west-2") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  aggregate_findings               = var.region == "eu-west-2"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_eu-west-3" {
  count  = contains(var.target_regions, "eu-west-3") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  aggregate_findings               = var.region == "eu-west-3"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_sa-east-1" {
  count  = contains(var.target_regions, "sa-east-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  aggregate_findings               = var.region == "sa-east-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_us-east-1" {
  count  = contains(var.target_regions, "us-east-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.us-east-1
  }

  aggregate_findings               = var.region == "us-east-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_us-east-2" {
  count  = contains(var.target_regions, "us-east-2") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.us-east-2
  }

  aggregate_findings               = var.region == "us-east-2"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_us-west-1" {
  count  = contains(var.target_regions, "us-west-1") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.us-west-1
  }

  aggregate_findings               = var.region == "us-west-1"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}

module "securityhub_baseline_us-west-2" {
  count  = contains(var.target_regions, "us-west-2") && var.securityhub_enabled ? 1 : 0
  source = "./modules/securityhub-baseline"

  providers = {
    aws = aws.us-west-2
  }

  aggregate_findings               = var.region == "us-west-2"
  enable_cis_standard              = var.securityhub_enable_cis_standard
  enable_pci_dss_standard          = var.securityhub_enable_pci_dss_standard
  enable_aws_foundational_standard = var.securityhub_enable_aws_foundational_standard
  enable_product_arns              = var.securityhub_enable_product_arns
  master_account_id                = local.securityhub_master_account_id
  member_accounts                  = local.securityhub_member_accounts
}
