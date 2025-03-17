output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.id
}
