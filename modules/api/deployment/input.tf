variable "stage" {
  type    = string
}

variable "api" {
  description = "API Gateway"
}

variable "integrations" {
  description = "List of integrations to trigger a redeployment"
}