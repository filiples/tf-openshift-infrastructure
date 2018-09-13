# Networking

vpc_cidr = "10.0.0.0/16"
public_cidrs = [
  "10.0.128.0/20",
  "10.0.144.0/20",
  "10.0.160.0/20"
]
private_cidrs = [
  "10.0.0.0/19",
  "10.0.32.0/19",
  "10.0.64.0/19"
]
accessip = "0.0.0.0/0"

# Compute

# Using t2.micro instances until terraform files complete

instance_count_master = 3

instance_type_master = "t2.micro"

instance_count_infra_node = 2

instance_type_infra_node = "t2.micro"

instance_count_app_node = 2

instance_type_app_node = "t2.micro"

master_root_block_device_size = 45

node_root_block_device_size = 20
