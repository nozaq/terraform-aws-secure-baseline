output "default_vpc_id" {
  description = "The ID of the default VPC."
  value       = "${aws_default_vpc.default.id}"
}

output "default_security_group_id" {
  description = "The ID of the default security group."
  value       = "${aws_default_security_group.default.id}"
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL."
  value       = "${aws_default_network_acl.default.id}"
}

output "default_route_table_id" {
  description = "The ID of the default route table."
  value       = "${aws_default_route_table.default.id}"
}

output "vpc_flow_logs_group_arn" {
  description = "The ARN of the CloudWatch Logs log group which stores VPC Flow Logs."
  value       = "${aws_cloudwatch_log_group.default_vpc_flow_logs.arn}"
}

output "vpc_flow_logs_group_name" {
  description = "The name of the CloudWatch Logs log group which stores VPC Flow Logs."
  value       = "${aws_cloudwatch_log_group.default_vpc_flow_logs.name}"
}
