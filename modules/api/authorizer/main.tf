resource "aws_api_gateway_authorizer" "authorizer" {
  name                   = var.domain
	type                   = "COGNITO_USER_POOLS"
  rest_api_id            = var.api.id
	provider_arns          = [var.auth_provider.arn]
}