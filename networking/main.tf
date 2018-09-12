data "aws_availability_zones" "available" {}

resource "aws_vpc" "openshift_tf_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "openshift_tf_vpc"
  }
}
