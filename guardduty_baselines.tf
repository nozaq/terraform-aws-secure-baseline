module "guardduty_baseline_ap-northeast-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.ap-northeast-1"
  }
}

module "guardduty_baseline_ap-northeast-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.ap-northeast-2"
  }
}

module "guardduty_baseline_ap-south-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.ap-south-1"
  }
}

module "guardduty_baseline_ap-southeast-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.ap-southeast-1"
  }
}

module "guardduty_baseline_ap-southeast-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.ap-southeast-2"
  }
}

module "guardduty_baseline_ca-central-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.ca-central-1"
  }
}

module "guardduty_baseline_eu-central-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.eu-central-1"
  }
}

module "guardduty_baseline_eu-west-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.eu-west-1"
  }
}

module "guardduty_baseline_eu-west-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.eu-west-2"
  }
}

# GuardDuty is not supported in eu-west-3(Paris) region.
# https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/
# module "guardduty_baseline_eu-west-3" {
#   source = "./modules/guardduty-baseline"
#
#   providers = {
#     aws = "aws.eu-west-3"
#   }
# }

module "guardduty_baseline_sa-east-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.sa-east-1"
  }
}

module "guardduty_baseline_us-east-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.us-east-1"
  }
}

module "guardduty_baseline_us-east-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.us-east-2"
  }
}

module "guardduty_baseline_us-west-1" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.us-west-1"
  }
}

module "guardduty_baseline_us-west-2" {
  source = "./modules/guardduty-baseline"

  providers = {
    aws = "aws.us-west-2"
  }
}
