resource "aws_route53_record" "ipv4" {
  zone_id = var.zone.zone_id
  name    = var.domain
  type    = "A"
  alias {
    evaluate_target_health = false
    name    = var.target.domain_name
    zone_id = var.target.hosted_zone_id
  }
}

resource "aws_route53_record" "ipv6" {
  zone_id = var.zone.zone_id
  name    = var.domain
  type    = "AAAA"
  alias {
    evaluate_target_health = false
    name    = var.target.domain_name
    zone_id = var.target.hosted_zone_id
  }
}

