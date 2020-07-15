resource "aws_api_gateway_deployment" "api" {
  rest_api_id = var.api.id
  stage_name  = var.stage

  triggers = {
    redeployment = sha1(join(",", var.integrations))
  }

  lifecycle {
    create_before_destroy = true
  }
}