variable "domain_name" {
  type = string
	description = "The domain name for the api"
}

variable "certificate_arn" {
	type = string
	description = "The certificate arn for the api domain"
}

variable "api_depends_on" {
	type = any
	default = null
}

variable "api_id" {
	type = string
	description = "The api id"
}

variable "stage_name" {
	type = string
	description = "The stage name to be mapped"
}

variable "base_path" {
	type = string
	description = "The base path to map the stage to"
}
