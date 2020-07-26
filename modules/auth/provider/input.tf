variable "name" {
	type = string
	description = "The name of the authentication provider"
}

variable "signup" {
	type = bool
	description = "Allow self signup"
	default = false 
}