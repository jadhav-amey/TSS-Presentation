variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string

}

variable "node_instance_type" {
  description = "Instance type for the EKS worker nodes"
  type        = string

}

variable "min_capacity" {
  description = "Minimum number of worker nodes"
  type        = number

}

variable "max_capacity" {
  description = "Maximum number of worker nodes"
  type        = number

}

variable "desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number

}

variable "ecr_repository_name" {
  description = "Name of the ECR repository"
  type        = string
}
