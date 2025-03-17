provider "aws" {
  region = var.aws_region
}

# backend configuration for terraform state
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
