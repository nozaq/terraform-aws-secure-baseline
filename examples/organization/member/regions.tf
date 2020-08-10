# --------------------------------------------------------------------------------------------------
# A list of providers for all AWS regions.
# Reference: https://docs.aws.amazon.com/general/latest/gr/rande.html
# --------------------------------------------------------------------------------------------------

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-1"
  alias      = "ap-northeast-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-2"
  alias      = "ap-northeast-2"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-northeast-3"
  alias      = "ap-northeast-3"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-south-1"
  alias      = "ap-south-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-southeast-1"
  alias      = "ap-southeast-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ap-southeast-2"
  alias      = "ap-southeast-2"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "ca-central-1"
  alias      = "ca-central-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-central-1"
  alias      = "eu-central-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-north-1"
  alias      = "eu-north-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-west-1"
  alias      = "eu-west-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-west-2"
  alias      = "eu-west-2"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "eu-west-3"
  alias      = "eu-west-3"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "sa-east-1"
  alias      = "sa-east-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
  alias      = "us-east-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-2"
  alias      = "us-east-2"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-west-1"
  alias      = "us-west-1"
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-west-2"
  alias      = "us-west-2"
}

