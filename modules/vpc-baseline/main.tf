data "aws_availability_zones" "available" {}

# --------------------------------------------------------------------------------------------------
# Creates a log group for VPC Flow Logs
# --------------------------------------------------------------------------------------------------

resource "aws_cloudwatch_log_group" "default_vpc_flow_logs" {
  name              = "${var.vpc_log_group_name}"
  retention_in_days = "${var.vpc_log_retention_in_days}"
}

# --------------------------------------------------------------------------------------------------
# Clears rules associated with default resources.
# --------------------------------------------------------------------------------------------------

resource "aws_default_vpc" "default" {
  tags {
    Name = "Default VPC"
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_default_vpc.default.default_route_table_id}"

  tags {
    Name = "Default Route Table"
  }
}

// Ignore "subnet_ids" changes to avoid the known issue below.
// https://github.com/hashicorp/terraform/issues/9824
// https://github.com/terraform-providers/terraform-provider-aws/issues/346
resource "aws_default_network_acl" "default" {
  lifecycle {
    ignore_changes = ["subnet_ids"]
  }

  default_network_acl_id = "${aws_default_vpc.default.default_network_acl_id}"

  tags {
    Name = "Default Network ACL"
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_default_vpc.default.id}"

  tags {
    Name = "Default Security Group"
  }
}

# --------------------------------------------------------------------------------------------------
# Enable VPC Flow Logs for the default VPC.
# --------------------------------------------------------------------------------------------------

resource "aws_flow_log" "default_vpc_flow_logs" {
  log_destination = "${aws_cloudwatch_log_group.default_vpc_flow_logs.arn}"
  iam_role_arn    = "${var.vpc_flow_logs_iam_role_arn}"
  vpc_id          = "${aws_default_vpc.default.id}"
  traffic_type    = "ALL"
}
