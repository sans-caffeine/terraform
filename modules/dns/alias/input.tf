variable "domain" {
	type = string
	description = "The domain name for the alias record"
}

variable "zone" {
	description = "The zone record for the domain"
}

variable "target" {
	description = "The target cdn for the alias"
}