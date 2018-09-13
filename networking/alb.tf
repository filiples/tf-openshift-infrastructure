resource "aws_lb" "openshift_lb" {
    name = "openshift-lb"
    subnets = ["${aws_subnet.openshift_tf_public_subnet.*.id}"]
    security_groups = ["${aws_security_group.openshift_master_sg.id}", "${aws_security_group.openshift_infra_sg.id}"]

    internal = false
    load_balancer_type = "application"

    tags {
        Name = "openshift-lb"
    }
}