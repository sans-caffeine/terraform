variable "domain" {
  type = string
  description = "Domain name of website"
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