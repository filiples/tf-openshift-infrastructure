# Public route table

resource "aws_route_table" "openshift_tf_public_rt" {
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.openshift_tf_igw.id}"
  }

  tags {
    Name = "openshift_tf_public_rt"
  }
}

# Public subnet

resource "aws_subnet" "openshift_tf_public_subnet" {
  count                   = 3
  vpc_id                  = "${aws_vpc.openshift_tf_vpc.id}"
  cidr_block              = "${var.public_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "openshift_tf_public_${count.index + 1}"
  }
}

# Public route association

resource "aws_route_table_association" "openshift_tf_public_assoc" {
  count          = "${aws_subnet.openshift_tf_public_subnet.count}"
  subnet_id      = "${aws_subnet.openshift_tf_public_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.openshift_tf_public_rt.id}"
}

# Private subnet

resource "aws_subnet" "openshift_tf_private_subnet" {
  count                   = 3
  vpc_id                  = "${aws_vpc.openshift_tf_vpc.id}"
  cidr_block              = "${var.private_cidrs[count.index]}"
  map_public_ip_on_launch = true
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "openshift_tf_private_${count.index + 1}"
  }
}

# Private route table

resource "aws_route_table" "openshift_tf_private_rt" {
  count  = "${aws_subnet.openshift_tf_private_subnet.count}"
  vpc_id = "${aws_vpc.openshift_tf_vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.openshift_tf_nat_gateway.*.id[count.index]}"
  }

  tags {
    Name = "openshift_tf_private_rt-${count.index}"
  }
}

# Private route table associtation

resource "aws_route_table_association" "openshift_tf_private_assoc" {
  count          = "${aws_subnet.openshift_tf_private_subnet.count}"
  subnet_id      = "${aws_subnet.openshift_tf_private_subnet.*.id[count.index]}"
  route_table_id = "${aws_route_table.openshift_tf_private_rt.*.id[count.index]}"
}
