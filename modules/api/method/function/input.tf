variable "api" {
  description = "api"
}

variable "resource" {
  description = "resource"
}

variable "method" {
  type    = string 
  description = "Http method"
}

variable "function" {
  description = "Function to add to this api"
}

variable "authorizer_id" {
  description = "The authorizer id used for validating authorisation"
  default = null
}

variable "scopes" {
  type = list(string)
  description = "The valid scopes a user requires to be authorised to this method"
  default = null
}

