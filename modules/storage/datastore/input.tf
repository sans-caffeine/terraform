variable "env" {
  type = string
  description = "Environment"
}

variable "name" {
  type = string 
  description = "table name"
}

variable "role" {
  description = "The IAM role to attach the policy"
}