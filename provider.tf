terraform {
  backend "s3" {
    bucket  = "eks-tf-state-file-bucket"
    key     = "eks/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}
