variable "domain" {
  type = string
  description = "The domain for the website"
}

variable "public_bucket" {
  description = "The storage bucket to be used for the public files"
}

variable "public_bucket_access_block" {
  description = "The public storage bucket public access block"
}

variable "behaviors" {
	description = "Cache behaviour settings"
	default = []
}

variable "aliases" {
	type = list(string)
	description = "The domain aliases for this website"
	default = []
}

variable "certificate_arn" {
	type = string
	description = "The TLS certificate arn"
	default = null
}