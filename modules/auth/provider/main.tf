locals {
  name = replace(var.domain,".","-")
}

resource "aws_cognito_user_pool" "user_pool" {
  name = local.name
  auto_verified_attributes = [ "email" ]
  alias_attributes = [ "email", "preferred_username" ]
  admin_create_user_config {
    allow_admin_create_user_only = !var.signup
  }

  schema {
    name = "email"
    attribute_data_type = "String" 
    required = true 
    mutable = true
    developer_only_attribute = false 
    
    string_attribute_constraints {
      min_length = 0 
      max_length = 2048
    } 
  } 
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = local.name
  user_pool_id = aws_cognito_user_pool.user_pool.id
}