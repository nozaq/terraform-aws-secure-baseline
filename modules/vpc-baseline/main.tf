locals {
  flow_logs_to_cw_logs = var.enable_flow_logs && var.flow_logs_destination_type == "cloud-watch-logs"
}

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = [true]
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

# --------------------------------------------------------------------------------------------------
# Enable VPC Flow Logs for the default VPC.
# --------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "default_vpc_flow_logs" {
  count = var.enable_flow_logs && local.flow_logs_to_cw_logs ? 1 : 0

  name              = var.flow_logs_log_group_name
  retention_in_days = var.flow_logs_retention_in_days

  tags = var.tags
}

resource "aws_flow_log" "default_vpc_flow_logs" {
  count = var.enable_flow_logs ? 1 : 0

  log_destination_type = var.flow_logs_destination_type
  log_destination      = local.flow_logs_to_cw_logs ? aws_cloudwatch_log_group.default_vpc_flow_logs[0].arn : "${var.flow_logs_s3_arn}/${var.flow_logs_s3_key_prefix}"
  iam_role_arn         = local.flow_logs_to_cw_logs ? var.flow_logs_iam_role_arn : null
  vpc_id               = aws_default_vpc.default.id
  traffic_type         = "ALL"

  tags = var.tags
}

# --------------------------------------------------------------------------------------------------
# Clears rules associated with default resources.
# --------------------------------------------------------------------------------------------------

resource "aws_default_vpc" "default" {
  tags = merge(
    var.tags,
    { Name = "Default VPC" }
  )
}

resource "aws_default_subnet" "default" {
  for_each = data.aws_subnet.default

  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = merge(
    var.tags,
    { Name = "Default Subnet" }
  )
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_default_vpc.default.default_route_table_id

  tags = merge(
    var.tags,
    { Name = "Default Route Table" }
  )
}

# Ignore "subnet_ids" changes to avoid the known issue below.
# https://github.com/hashicorp/terraform/issues/9824
# https://github.com/terraform-providers/terraform-provider-aws/issues/346
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_default_vpc.default.default_network_acl_id

  tags = merge(
    var.tags,
    { Name = "Default Network ACL" }
  )

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default.id

  tags = merge(
    var.tags,
    { Name = "Default Security Group" }
  )
}
