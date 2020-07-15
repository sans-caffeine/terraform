variable "domain" {
	type = string
	description = "domain name of website"
}

variable "zone" {
	description = "Zone defined in route53"
}

variable "certificate" {
	description = "Certificate for auth var.domain"
}

variable "auth_provider" {
	description = "Authentication provider"
}

variable "iam_depends_on" {
  type    = any
  default = null
}