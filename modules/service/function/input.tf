variable "env" {
  type    = string
  description = "The name of the environment"
}

variable "name" {
  type    = string
  description = "The name of the function"
}

variable "role" {
  description = "The security role for this function"
}