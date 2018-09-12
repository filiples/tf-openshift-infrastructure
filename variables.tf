variable "aws_region" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}

# Networking

variable "vpc_cidr" {}

variable "public_cidrs" {
  type = "list"
}

variable "private_cidrs" {
  type = "list"
}

variable "accessip" {}

# Compute

variable "instance_count_master" {}

variable "instance_type_master" {}

variable "instance_count_infra_node" {}

variable "instance_type_infra_node" {}

variable "instance_count_app_node" {}

variable "instance_type_app_node" {}
