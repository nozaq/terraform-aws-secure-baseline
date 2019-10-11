# --------------------------------------------------------------------------------------------------
# Creates a log group for VPC Flow Logs
# --------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "default_vpc_flow_logs" {
  count = var.enabled ? 1 : 0

  name              = var.vpc_log_group_name
  retention_in_days = var.vpc_log_retention_in_days

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# Clears rules associated with default resources.
# --------------------------------------------------------------------------------------------------

resource "aws_default_vpc" "default" {
  count = var.enabled ? 1 : 0

  tags = {
    Name = "Default VPC"
  }
}

resource "aws_default_route_table" "default" {
  count = var.enabled ? 1 : 0

  default_route_table_id = aws_default_vpc.default[0].default_route_table_id

  tags = {
    Name = "Default Route Table"
  }
}

// Ignore "subnet_ids" changes to avoid the known issue below.
// https://github.com/hashicorp/terraform/issues/9824
// https://github.com/terraform-providers/terraform-provider-aws/issues/346
resource "aws_default_network_acl" "default" {
  count = var.enabled ? 1 : 0

  default_network_acl_id = aws_default_vpc.default[0].default_network_acl_id

  tags = {
    Name = "Default Network ACL"
  }

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}

resource "aws_default_security_group" "default" {
  count = var.enabled ? 1 : 0

  vpc_id = aws_default_vpc.default[0].id

  tags = {
    Name = "Default Security Group"
  }
}

# --------------------------------------------------------------------------------------------------
# Enable VPC Flow Logs for the default VPC.
# --------------------------------------------------------------------------------------------------

resource "aws_flow_log" "default_vpc_flow_logs" {
  count = var.enabled ? 1 : 0

  log_destination = aws_cloudwatch_log_group.default_vpc_flow_logs[0].arn
  iam_role_arn    = var.vpc_flow_logs_iam_role_arn
  vpc_id          = aws_default_vpc.default[0].id
  traffic_type    = "ALL"
}

