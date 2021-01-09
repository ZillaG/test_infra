provider "aws" {
  region                  = var.region
  profile                 = var.profile
}

terraform {
  required_version = ">= 0.12.17, < 0.15"
  backend "s3" {
    bucket  = "cfouts-tf-states"
    key     = "test/terraform.tfstate"
    region  = "us-east-1"
    profile = "test_user"
  }
}
