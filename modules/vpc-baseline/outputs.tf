output "default_vpc" {
  description = "The default VPC."
  value       = var.enabled ? aws_default_vpc.default[0] : null
}

output "default_security_group" {
  description = "The default security group."
  value       = var.enabled ? aws_default_security_group.default[0] : null
}

output "default_network_acl" {
  description = "The default network ACL."
  value       = var.enabled ? aws_default_network_acl.default[0] : null
}

output "default_route_table" {
  description = "The default route table."
  value       = var.enabled ? aws_default_route_table.default[0] : null
}

output "vpc_flow_logs_group" {
  description = "The CloudWatch Logs log group which stores VPC Flow Logs."
  value       = var.enabled && local.is_cw_logs ? aws_cloudwatch_log_group.default_vpc_flow_logs[0] : null
}
