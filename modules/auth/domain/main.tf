resource "aws_cognito_user_pool_domain" "custom_domain" {
  domain          = "auth.${var.domain}"
  certificate_arn = var.certificate.certificate_arn
  user_pool_id    = var.auth_provider.id

  depends_on = [var.iam_depends_on]
}

resource "aws_route53_record" "auth_v4" {
  name    = "auth.${var.domain}" 
  type    = "A"
  zone_id = var.zone.zone_id

  alias {
    evaluate_target_health = false
    name    = aws_cognito_user_pool_domain.custom_domain.cloudfront_distribution_arn
    zone_id = "Z2FDTNDATAQYW2"
  }
}

resource "aws_route53_record" "auth_v6" {
  name    = "auth.${var.domain}"
  type    = "AAAA"
  zone_id = var.zone.zone_id

  alias {
    evaluate_target_health = false
    name    = aws_cognito_user_pool_domain.custom_domain.cloudfront_distribution_arn
    zone_id = "Z2FDTNDATAQYW2"
  }
}
