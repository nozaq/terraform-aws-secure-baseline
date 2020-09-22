resource "aws_accessanalyzer_analyzer" "default" {
  count = var.enabled ? 1 : 0

  analyzer_name = var.analyzer_name
  type          = var.is_organization ? "ORGANIZATION" : "ACCOUNT"

  tags = var.tags
}
