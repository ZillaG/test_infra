provider "aws" {
  region                  = var.region
  profile                 = var.profile
//  shared_credentials_file = var.aws_creds_file
//  access_key              = "AKIARK6YE4WH7KYLA56A"
//  secret_key              = "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"
//  access_key              = "AKIARK6YE4WHVMRXMYMB"
//  secret_key              = "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"
}

terraform {
  required_version = ">= 0.12.17, < 0.13"
/*
  backend "s3" {
    bucket = "cfouts-tf-states"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
*/
}
