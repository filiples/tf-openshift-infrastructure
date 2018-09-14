data "aws_ami" "server_ami" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/install-ansible.tpl")}"
}

resource "aws_instance" "openshift_master" {
  count                  = "${var.instance_count_master}"
  instance_type          = "${var.instance_type_master}"
  ami                    = "${data.aws_ami.server_ami.id}"
  subnet_id              = "${var.public_subnet_ids[count.index]}"
  vpc_security_group_ids = ["${var.openshift_ssh_sg}", "${var.openshift_master_sg}"]
  key_name               = "${var.instance_key_name}"
  associate_public_ip_address = false

  root_block_device {
    volume_size = "${var.master_root_block_device_size}"
    volume_type = "gp2"
  }

  tags {
    Name = "openshift-master-${count.index + 1}"
  }
}

resource "aws_instance" "openshift_infra_node" {
  count                  = "${var.instance_count_infra_node}"
  instance_type          = "${var.instance_type_infra_node}"
  ami                    = "${data.aws_ami.server_ami.id}"
  subnet_id              = "${var.public_subnet_ids[count.index]}"
  vpc_security_group_ids = ["${var.openshift_ssh_sg}", "${var.openshift_infra_sg}"]
  key_name               = "${var.instance_key_name}"
  associate_public_ip_address = false

  root_block_device {
    volume_size = "${var.node_root_block_device_size}"
    volume_type = "gp2"
  }

  tags {
    Name = "openshift-infra-node-${count.index + 1}"
  }
}

resource "aws_instance" "openshift_app_node" {
  count                  = "${var.instance_count_app_node}"
  instance_type          = "${var.instance_type_app_node}"
  ami                    = "${data.aws_ami.server_ami.id}"
  subnet_id              = "${var.public_subnet_ids[count.index]}"
  vpc_security_group_ids = ["${var.openshift_ssh_sg}", "${var.openshift_node_sg}"]
  key_name               = "${var.instance_key_name}"
  associate_public_ip_address = false

  root_block_device {
    volume_size = "${var.node_root_block_device_size}"
    volume_type = "gp2"
  }

  tags {
    Name = "openshift-app-node-${count.index + 1}"
  }
}

# Ansible config server

resource "aws_instance" "ansible_config_server" {
  instance_type          = "m3.medium"
  ami                    = "${data.aws_ami.server_ami.id}"
  subnet_id              = "${var.public_subnet_ids[0]}"
  vpc_security_group_ids = ["${var.openshift_ssh_sg}", "${var.public_web_sg}"]
  key_name               = "${var.instance_key_name}"

  user_data = "${data.template_file.user_data.rendered}"

  tags {
    Name = "Ansible config server"
  }
}
