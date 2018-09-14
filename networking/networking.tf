# Internet gateway

resource "aws_internet_gateway" "openshift_tf_igw" {
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  tags {
    Name = "Openshift tf IGW"
  }
}

# IGW route to internet

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.openshift_tf_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.openshift_tf_igw.id}"
}

# Elastic IP for NAT gateway

resource "aws_eip" "openshift_tf_eip" {
  count = "${aws_subnet.openshift_tf_public_subnet.count}"
  vpc   = true

  tags {
    Name = "NAT gateway eip - ${count.index}"
  }
}

# NAT gateway

resource "aws_nat_gateway" "openshift_tf_nat_gateway" {
  count         = "${aws_subnet.openshift_tf_public_subnet.count}"
  subnet_id     = "${aws_subnet.openshift_tf_public_subnet.*.id[count.index]}"
  allocation_id = "${aws_eip.openshift_tf_eip.*.id[count.index]}"

  depends_on = ["aws_internet_gateway.openshift_tf_igw"]

  tags {
    Name = "Openshift NAT gateway"
  }
}
