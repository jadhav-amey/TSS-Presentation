variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for public subnet 1"
  type        = string
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for public subnet 2"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability Zone for subnet 1"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability Zone for subnet 2"
  type        = string
}

variable "eks_cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "instance_type" {
  description = "Instance type for worker nodes"
  type        = string
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "ecr_name" {
  description = "ECR repository name"
  type        = string
}
