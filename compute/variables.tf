variable "openshift_ssh_sg" {}

variable "public_web_sg" {}

variable "openshift_master_sg" {}

variable "openshift_node_sg" {}

variable "openshift_infra_sg" {}

variable "public_subnet_ids" {
  type = "list"
}

variable "instance_count_master" {}

variable "instance_type_master" {}

variable "instance_count_infra_node" {}

variable "instance_type_infra_node" {}

variable "instance_count_app_node" {}

variable "instance_type_app_node" {}

variable "master_root_block_device_size" {}

variable "node_root_block_device_size" {}

variable "instance_key_name" {}
