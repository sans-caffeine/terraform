resource "aws_api_gateway_domain_name" "api" {
  certificate_arn = var.certificate_arn
  domain_name     = var.domain_name

	depends_on = [var.api_depends_on]
}

//Change to handle multiple mappings
resource "aws_api_gateway_base_path_mapping" "api" {
  api_id      = var.api_id
  domain_name = var.domain_name
  stage_name  = var.stage_name
  base_path   = var.base_path

	depends_on = [aws_api_gateway_domain_name.api]
}