//The Route53 Zone is created by AWS or can be created manually 
data "aws_route53_zone" "zone" {
  name = var.domain
}

/*
//Route 53 Zone - import from AWS if registering via route53
resource "aws_route53_zone" "zone" {
  name          = var.domain
	comment       = "HostedZone created by Route53 Registrar"
	force_destroy = false 
}

//Route 53 NS Record - import from AWS if registering via route53
//Added dot after record name looks like a bug in import / compare process
resource "aws_route53_record" "NS" {
//  allow_overwrite = true
  name            = var.domain
  ttl             = 172800
  type            = "NS"
  zone_id         = aws_route53_zone.zone.zone_id

  records = [
    "${aws_route53_zone.zone.name_servers.0}.",
    "${aws_route53_zone.zone.name_servers.1}.",
    "${aws_route53_zone.zone.name_servers.2}.",
    "${aws_route53_zone.zone.name_servers.3}."
  ]
}

//Route 53 SOA Record - can the record values be picked up from the zone?
resource "aws_route53_record" "SOA" {
	zone_id = aws_route53_zone.zone.zone_id
	name    = var.domain
	type    = "SOA"
	ttl     = 900
	records = [ "${aws_route53_zone.zone.name_servers.2}. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400" ]
}
*/