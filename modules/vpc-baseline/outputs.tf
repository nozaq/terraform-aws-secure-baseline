output "default_vpc_id" {
  value = "${aws_default_vpc.default.id}"
}

output "default_security_group_id" {
  value = "${aws_default_security_group.default.id}"
}

output "default_network_acl_id" {
  value = "${aws_default_network_acl.default.id}"
}

output "default_route_table_id" {
  value = "${aws_default_route_table.default.id}"
}
