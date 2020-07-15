resource "aws_api_gateway_method" "options" {
  rest_api_id   = var.api.id
  resource_id   = var.resource.id
  http_method   = "OPTIONS"

  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "options" {
  rest_api_id   = var.api.id
  resource_id   = var.resource.id
  http_method   = aws_api_gateway_method.options.http_method
  status_code   = 200
	
  response_models = {
    "application/json" = "Empty"
  }	

  response_parameters = { 
    "method.response.header.Access-Control-Allow-Headers" = true 
    "method.response.header.Access-Control-Allow-Methods" = true 
    "method.response.header.Access-Control-Allow-Origin" = true 
  }

  depends_on = [
    aws_api_gateway_method.options
  ]
}

resource "aws_api_gateway_integration" "options" {
  rest_api_id   = var.api.id
  resource_id   = var.resource.id
  http_method   = aws_api_gateway_method.options.http_method
  type          = "MOCK"
  request_templates = {
    "application/json" = "{ \"statusCode\": 200 }"
  }
}

resource "aws_api_gateway_integration_response" "options" {
  rest_api_id   = var.api.id
  resource_id   = var.resource.id
  http_method   = aws_api_gateway_method.options.http_method
  status_code   = 200 

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT,DELETE'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_integration.options,
    aws_api_gateway_method_response.options
  ]
}