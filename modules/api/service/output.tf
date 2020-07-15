output "resources" {
  value = aws_api_gateway_resource.resources
}

output "resource" {
  value = aws_api_gateway_resource.resource
}

output "integrations" {
  value = list(
    jsonencode( module.method_resources_options.integration ),
    jsonencode( module.method_resources_get.integration ),
    jsonencode( module.method_resources_post.integration ),
    jsonencode( module.method_resource_id_options.integration ),
    jsonencode( module.method_resource_id_delete.integration ),
    jsonencode( module.method_resource_id_put.integration ),
    jsonencode( module.method_resource_id_get.integration ),
  )
}