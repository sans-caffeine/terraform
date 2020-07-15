resource "aws_api_gateway_base_path_mapping" "api" {
  api_id      = var.api_id
  domain_name = var.domain_name
  stage_name  = var.stage_name
  base_path   = var.base_path
}