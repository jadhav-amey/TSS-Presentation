# Fetch AWS Availability Zones dynamically
data "aws_availability_zones" "available" {}

# VPC Module
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
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      node_group_name = var.node_group_name
      instance_types  = [var.node_instance_type]
      min_size        = var.min_capacity
      max_size        = var.max_capacity
      desired_size    = var.desired_capacity

      iam_role_arn = aws_iam_role.eks_nodes.arn # Adding IAM role for worker nodes
    }
  }
}

# IAM Role for EKS Node Group
resource "aws_iam_role" "eks_nodes" {
  name = "eks-node-group-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Attach Required Policies to worker nodes
resource "aws_iam_role_policy_attachment" "eks_worker_node" {
  role       = aws_iam_role.eks_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni" {
  role       = aws_iam_role.eks_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_container_registry" {
  role       = aws_iam_role.eks_nodes.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
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
