resource "aws_api_gateway_resource" "resources" {
  rest_api_id = var.api.id
  parent_id   = var.parent_id
  path_part   = var.name
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = var.api.id
  parent_id   = aws_api_gateway_resource.resources.id
  path_part   = "{${var.resource_id}}"
}

module "method_resources_options" {
  source = "../method/options_cors"

  api           = var.api
  resource      = aws_api_gateway_resource.resources
}

module "method_resources_get" {
  source = "../method/function"

  api           = var.api
  resource      = aws_api_gateway_resource.resources
  function      = var.function
  method        = "GET"
}

module "method_resources_post" {
  source = "../method/function"

  api           = var.api
  resource      = aws_api_gateway_resource.resources
  function      = var.function
  method        = "POST"
	authorizer_id = var.authorizer_id
	scopes        = var.scopes
}

module "method_resource_id_options" {
  source = "../method/options_cors"

  api           = var.api
  resource      = aws_api_gateway_resource.resource
}

module "method_resource_id_get" {
  source = "../method/function"

  api           = var.api
  resource      = aws_api_gateway_resource.resource
  function      = var.function
  method        = "GET"
}

module "method_resource_id_put" {
  source = "../method/function"

  api           = var.api
  resource      = aws_api_gateway_resource.resource
  function      = var.function
  method        = "PUT"
	authorizer_id = var.authorizer_id
	scopes        = var.scopes
}

module "method_resource_id_delete" {
  source = "../method/function"

  api           = var.api
  resource      = aws_api_gateway_resource.resource
  function      = var.function
  method        = "DELETE"
	authorizer_id = var.authorizer_id
	scopes        = var.scopes
}