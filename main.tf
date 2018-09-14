provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

# Deploy Networking Resources

module "networking" {
  source        = "./networking"
  vpc_cidr      = "${var.vpc_cidr}"
  public_cidrs  = "${var.public_cidrs}"
  private_cidrs = "${var.private_cidrs}"
  accessip      = "${var.accessip}"
}

# Deploy Compute Resources

module "compute" {
  source                        = "./compute"
  public_subnet_ids             = "${module.networking.public_subnets}"
  openshift_ssh_sg              = "${module.networking.openshift_ssh_sg}"
  public_web_sg                 = "${module.networking.public_web_sg}"
  openshift_master_sg           = "${module.networking.openshift_master_sg}"
  openshift_node_sg             = "${module.networking.openshift_node_sg}"
  openshift_infra_sg            = "${module.networking.openshift_infra_sg}"
  instance_count_master         = "${var.instance_count_master}"
  instance_type_master          = "${var.instance_type_master}"
  instance_count_infra_node     = "${var.instance_count_infra_node}"
  instance_type_infra_node      = "${var.instance_type_infra_node}"
  instance_count_app_node       = "${var.instance_count_app_node}"
  instance_type_app_node        = "${var.instance_type_app_node}"
  master_root_block_device_size = "${var.master_root_block_device_size}"
  node_root_block_device_size   = "${var.node_root_block_device_size}"
  instance_key_name             = "${var.instance_key_name}"
}
