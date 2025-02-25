aws_region          = "ap-south-1"
vpc_cidr            = "10.0.0.0/16"
cluster_name        = "eks-cluster"
node_instance_type  = "t3.medium"
desired_capacity    = 1
max_capacity        = 1
min_capacity        = 1
ecr_repository_name = "ecr-repo"
