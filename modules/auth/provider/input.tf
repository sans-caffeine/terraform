variable "domain" {
  type = string
  description = "The domain of the website"
}

variable "signup" {
	type = bool
	description = "Allow self signup"
	default = false 
}