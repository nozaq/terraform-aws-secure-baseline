locals {
  is_analyzer_enabled = var.analyzer_baseline_enabled && (local.is_individual_account || local.is_master_account)
}

# --------------------------------------------------------------------------------------------------
# Analyzer Baseline
# --------------------------------------------------------------------------------------------------

module "analyzer_baseline_ap-northeast-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "ap-northeast-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "ap-northeast-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_ap-northeast-2" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "ap-northeast-2") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "ap-northeast-2" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_ap-south-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "ap-south-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.ap-south-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "ap-south-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_ap-northeast-3" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "ap-northeast-3") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.ap-northeast-3
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "ap-northeast-3" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_ap-southeast-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "ap-southeast-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "ap-southeast-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_ap-southeast-2" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "ap-southeast-2") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "ap-southeast-2" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_ca-central-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "ca-central-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.ca-central-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "ca-central-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_eu-central-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "eu-central-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.eu-central-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "eu-central-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_eu-north-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "eu-north-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.eu-north-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "eu-north-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_eu-west-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "eu-west-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.eu-west-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "eu-west-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_eu-west-2" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "eu-west-2") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.eu-west-2
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "eu-west-2" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_eu-west-3" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "eu-west-3") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.eu-west-3
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "eu-west-3" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_sa-east-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "sa-east-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.sa-east-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "sa-east-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_us-east-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "us-east-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.us-east-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "us-east-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_us-east-2" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "us-east-2") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.us-east-2
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "us-east-2" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_us-west-1" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "us-west-1") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.us-west-1
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "us-west-1" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}

module "analyzer_baseline_us-west-2" {
  count  = local.is_analyzer_enabled && contains(var.target_regions, "us-west-2") ? 1 : 0
  source = "./modules/analyzer-baseline"

  providers = {
    aws = aws.us-west-2
  }

  analyzer_name              = var.analyzer_name
  is_organization            = local.is_master_account
  delegated_admin_account_id = var.region == "us-west-2" ? var.analyzer_delegated_admin_account_id : ""

  tags = var.tags
}
