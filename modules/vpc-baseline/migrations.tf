# --------------------------------------------------------------------------------------------------
# Migrations to 0.31.0
# Removing `enabled` argument.
# --------------------------------------------------------------------------------------------------

moved {
  from = aws_default_vpc.default[0]
  to   = aws_default_vpc.default
}

moved {
  from = aws_default_route_table.default[0]
  to   = aws_default_route_table.default
}

moved {
  from = aws_default_network_acl.default[0]
  to   = aws_default_network_acl.default
}

moved {
  from = aws_default_security_group.default[0]
  to   = aws_default_security_group.default
}
