provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = ""
    region         = "eu-central-1"
    dynamodb_table = "terraform-lock-table"
  }
}