variable "domain" {
  type    = string
  description = "The domain for this certificate"
}

variable "zone" {
  description = "AWS Route53 Zone for domain"
}

variable "subject_alternative_names" {
  type    = list(string)
  description = "The sub domains for this certificate"
  default = []
}