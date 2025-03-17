variable "aws_region" {
  default = "ap-south-1"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "eks_cluster_name" {}
variable "ecr_name" {}
variable "instance_type" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
