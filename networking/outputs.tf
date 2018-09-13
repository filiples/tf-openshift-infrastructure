output "public_subnets" {
  value = "${aws_subnet.openshift_tf_public_subnet.*.id}"
}

output "private_subnets" {
  value = "${aws_subnet.openshift_tf_private_subnet.*.id}"
}

output "openshift_master_sg" {
  value = "${aws_security_group.openshift_master_sg.id}"
}

output "openshift_node_sg" {
  value = "${aws_security_group.openshift_node_sg.id}"
}

output "openshift_infra_sg" {
  value = "${aws_security_group.openshift_infra_sg.id}"
}

output "openshift_ssh_sg" {
  value = "${aws_security_group.openshift_ssh_sg.id}"
}

output "public_web_sg" {
  value = "${aws_security_group.public_web_sg.id}"
}
