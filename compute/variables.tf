variable "public_sg" {}

variable "os_sg" {}

variable "public_subnet_ids" {
  type = "list"
}

variable "instance_count_master" {}

variable "instance_type_master" {}

variable "instance_count_infra_node" {}

variable "instance_type_infra_node" {}

variable "instance_count_app_node" {}

variable "instance_type_app_node" {}
