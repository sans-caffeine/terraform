//API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name        = var.domain
  description = "api.${var.domain}"
}