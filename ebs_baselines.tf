# --------------------------------------------------------------------------------------------------
# EBS Baseline
# --------------------------------------------------------------------------------------------------

module "ebs_baseline_ap-northeast-1" {
  count  = contains(var.target_regions, "ap-northeast-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ap-northeast-1
  }
}

module "ebs_baseline_ap-northeast-2" {
  count  = contains(var.target_regions, "ap-northeast-2") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ap-northeast-2
  }
}

module "ebs_baseline_ap-northeast-3" {
  count  = contains(var.target_regions, "ap-northeast-3") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ap-northeast-3
  }
}

module "ebs_baseline_ap-south-1" {
  count  = contains(var.target_regions, "ap-south-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ap-south-1
  }
}

module "ebs_baseline_ap-southeast-1" {
  count  = contains(var.target_regions, "ap-southeast-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ap-southeast-1
  }
}

module "ebs_baseline_ap-southeast-2" {
  count  = contains(var.target_regions, "ap-southeast-2") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ap-southeast-2
  }
}

module "ebs_baseline_ap-southeast-3" {
  count  = contains(var.target_regions, "ap-southeast-3") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ap-southeast-3
  }
}

module "ebs_baseline_ca-central-1" {
  count  = contains(var.target_regions, "ca-central-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.ca-central-1
  }
}

module "ebs_baseline_eu-central-1" {
  count  = contains(var.target_regions, "eu-central-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.eu-central-1
  }
}

module "ebs_baseline_eu-north-1" {
  count  = contains(var.target_regions, "eu-north-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.eu-north-1
  }
}

module "ebs_baseline_eu-west-1" {
  count  = contains(var.target_regions, "eu-west-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.eu-west-1
  }
}

module "ebs_baseline_eu-west-2" {
  count  = contains(var.target_regions, "eu-west-2") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.eu-west-2
  }
}

module "ebs_baseline_eu-west-3" {
  count  = contains(var.target_regions, "eu-west-3") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.eu-west-3
  }
}

module "ebs_baseline_me-south-1" {
  count  = contains(var.target_regions, "me-south-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.me-south-1
  }
}

module "ebs_baseline_sa-east-1" {
  count  = contains(var.target_regions, "sa-east-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.sa-east-1
  }
}

module "ebs_baseline_us-east-1" {
  count  = contains(var.target_regions, "us-east-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.us-east-1
  }
}

module "ebs_baseline_us-east-2" {
  count  = contains(var.target_regions, "us-east-2") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.us-east-2
  }
}

module "ebs_baseline_us-west-1" {
  count  = contains(var.target_regions, "us-west-1") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.us-west-1
  }
}

module "ebs_baseline_us-west-2" {
  count  = contains(var.target_regions, "us-west-2") ? 1 : 0
  source = "./modules/ebs-baseline"

  providers = {
    aws = aws.us-west-2
  }
}
