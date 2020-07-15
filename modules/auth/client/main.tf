locals {
  name = replace(var.domain,".","-")
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = local.name
  user_pool_id = var.auth_provider.id

  callback_urls = var.callback_urls
  logout_urls   = var.logout_urls
  refresh_token_validity = 30
  allowed_oauth_flows = [ "code" ] 
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = ["aws.cognito.signin.user.admin","email","openid","phone","profile"]
  supported_identity_providers = [ "COGNITO" ]

  read_attributes = [
    "address", 
    "birthdate", 
    "email", 
    "email_verified", 
    "family_name", 
    "gender", 
    "given_name", 
    "locale", 
    "middle_name", 
    "name", 
    "nickname", 
    "phone_number", 
    "phone_number_verified", 
    "picture", 
    "preferred_username", 
    "profile", 
    "updated_at", 
    "website", 
    "zoneinfo"
  ]

  write_attributes = [
    "address", 
    "birthdate", 
    "email", 
    "family_name", 
    "gender", 
    "given_name", 
    "locale", 
    "middle_name", 
    "name", 
    "nickname", 
    "phone_number", 
    "picture", 
    "preferred_username", 
    "profile", 
    "updated_at", 
    "website", 
    "zoneinfo"
  ]
}