# Fetch AWS Availability Zones dynamically
data "aws_availability_zones" "available" {}

# VPC module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.available.names
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true
}

# EKS Cluster Module
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.31"
  subnet_ids      = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      node_group_name = var.node_group_name
      instance_types  = [var.node_instance_type]
      min_size        = var.min_capacity
      max_size        = var.max_capacity
      desired_size    = var.desired_capacity
    }
  }
}

# ECR Module
module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name            = var.ecr_repository_name
  repository_force_delete    = true
  repository_encryption_type = "AES256"

  repository_lifecycle_policy = jsonencode({
    rules = [{
      rulePriority = 1
      description  = "Expire images older than 30 days"
      selection = {
        tagStatus   = "untagged"
        countType   = "sinceImagePushed"
        countUnit   = "days"
        countNumber = 30
      }
      action = { type = "expire" }
    }]
  })
}
