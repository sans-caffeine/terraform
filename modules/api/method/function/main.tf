locals {
  authorization = var.authorizer_id != null ? "COGNITO_USER_POOLS" : "NONE"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = var.api.id
  resource_id   = var.resource.id
  http_method   = var.method

  authorization = local.authorization
  authorizer_id = var.authorizer_id
  authorization_scopes = var.scopes
}

resource "aws_api_gateway_method_response" "method" {
  rest_api_id   = var.api.id
  resource_id   = var.resource.id
  http_method   = aws_api_gateway_method.method.http_method
  status_code   = 200
  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "method" {
  rest_api_id = var.api.id
  resource_id = var.resource.id
  http_method = aws_api_gateway_method.method.http_method

  content_handling        = "CONVERT_TO_TEXT"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.function.invoke_arn
}

resource "aws_api_gateway_integration_response" "method" {
  rest_api_id   = var.api.id
  resource_id   = var.resource.id
  http_method   = aws_api_gateway_method.method.http_method
  status_code   = aws_api_gateway_method_response.method.status_code
  response_templates = { 
    "application/json" = "null"
  }		

  depends_on = [aws_api_gateway_integration.method]
}

resource "aws_lambda_permission" "method" {
  action        = "lambda:InvokeFunction"
  function_name = var.function.arn
  principal     = "apigateway.amazonaws.com"
  source_arn 		= "${var.api.execution_arn}/*/${var.method}${var.resource.path}"
}