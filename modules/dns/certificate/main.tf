//Set up SSL certificate in us-east-1 (required for cloudfront)
provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "certificate" {
	provider = aws.us-east-1

  domain_name               = var.domain
  validation_method         = "DNS"
  subject_alternative_names = var.subject_alternative_names

  lifecycle {
    create_before_destroy = true
		ignore_changes = [subject_alternative_names]
  }

	options {
		certificate_transparency_logging_preference = "ENABLED"
	}
}

# Creates route 53 records for validation of DNS
resource "aws_route53_record" "certificate_validation" {
	provider = aws.us-east-1

  count   = length(var.subject_alternative_names) + 1
  name    = lookup(aws_acm_certificate.certificate.domain_validation_options[count.index], "resource_record_name")
  type    = lookup(aws_acm_certificate.certificate.domain_validation_options[count.index], "resource_record_type")
  records = [lookup(aws_acm_certificate.certificate.domain_validation_options[count.index], "resource_record_value")]
  zone_id = var.zone.id
  ttl     = 60
}

resource "aws_acm_certificate_validation" "certificate" {
	provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.certificate.arn

	validation_record_fqdns = [
		for record in aws_route53_record.certificate_validation:
		record.fqdn
	]
}

