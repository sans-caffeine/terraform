variable "env" {
  type = string
  description = "Environment"
}

variable "name" {
  type = string
  description = "service name"
}

variable "resource_id" {
  type = string
  description = "service id"
}

variable "api" {
  description = "API to attach resources"
}

variable "parent_id" {
  description = "Parent id to attach resources"
}

variable "function" {
  description = "Function for the api"
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