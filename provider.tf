provider "aws" {
  region = var.aws_region
}

# backend configuration for terraform state
terraform {
  backend "s3" {
    bucket = "eks-terraform-tfstate-file-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
