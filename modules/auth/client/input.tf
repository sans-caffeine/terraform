variable "name" {
  type = string
  description = "The name of the authentication client"
}

variable "auth_provider" {
  description = "Authentication Provider"
}

variable "callback_urls" {
  type = list(string)
  description = "A list of callback urls"
}

variable "logout_urls" {
  type = list(string)
  description = "A list of logout urls"
}