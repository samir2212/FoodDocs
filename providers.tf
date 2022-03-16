provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "fooddocs-terraform-state"
    key    = "fooddocs01-dev/terraform.tfstate"
    region = "eu-central-1"
  }
}
