output "auth_provider" {
  value = aws_cognito_user_pool.user_pool
}

output "auth_provider_domain" { 
  value = aws_cognito_user_pool_domain.user_pool_domain
}