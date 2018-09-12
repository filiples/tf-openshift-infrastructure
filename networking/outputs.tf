output "public_subnets" {
  value = "${aws_subnet.openshift_tf_public_subnet.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.openshift_tf_private_subnet.*.id}"
}

output "public_sg" {
  value = "${aws_security_group.openshift_tf_public_sg.id}"
}

output "os_sg" {
  value = "${aws_security_group.os_sg.id}"
}
