#VPC Output
output "vpc_id" {
  value = module.vpc.vpc_id
}

#EKS Output
output "eks_cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_arn" {
  value = module.eks.cluster_arn
}

#ECR Output
output "ecr_repository_url" {
  value = module.ecr.repository_url
}
