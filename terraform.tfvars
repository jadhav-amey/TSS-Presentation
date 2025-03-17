vpc_cidr         = "10.0.0.0/16"
subnet_cidr      = "10.0.1.0/24"
eks_cluster_name = "terraform-eks-cluster"
ecr_name         = "terraform-ecr-repo"
instance_type    = "t3.medium"
desired_size     = 1
max_size         = 1
min_size         = 1
