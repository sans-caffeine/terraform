variable "api_id" {
	type = string
	description = "The api id"
}

variable "domain_name" {
	type = string
	description = "The api domain name"
}

variable "stage_name" {
	type = string
	description = "The stage name to be mapped"
}

variable "base_path" {
	type = string
	description = "The base path to map the stage to"
}
