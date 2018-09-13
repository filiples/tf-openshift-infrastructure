# SSH security group

resource "aws_security_group" "openshift_ssh_sg" {
  name   = "openshift_ssh"
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  tags {
    Name = "Openshift SSH"
  }
}

# Public web security group

resource "aws_security_group" "public_web_sg" {
  name = "public_web_sg"
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  tags {
    Name = "Public web"
  }
}

# Openshift master security group

resource "aws_security_group" "openshift_master_sg" {
  name   = "os_master_sg"
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  ingress {
    from_port   = 8053
    to_port     = 8053
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  tags {
    Name = "Openshift master security group"
  }
}

# Openshift node security group

resource "aws_security_group" "openshift_node_sg" {
  name   = "os_node_sg"
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  # Restrict this to master
  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  # Restrict this to nodes
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["${var.accessip}"]
  }

  tags {
    Name = "Openshift node security group"
  }
}

# Openshift infra nodes security group

resource "aws_security_group" "openshift_infra_sg" {
  name   = "os_infra_sg"
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.accessip}"]
  }

  tags {
    Name = "Openshift infra node security group"
  }
}
