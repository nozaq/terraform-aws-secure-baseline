resource "aws_accessanalyzer_analyzer" "default" {
  analyzer_name = var.analyzer_name
  type          = var.is_organization ? "ORGANIZATION" : "ACCOUNT"

  tags = var.tags
}
