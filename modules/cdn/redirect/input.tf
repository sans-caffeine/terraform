variable "domain" { 
  type = string 
  description = "Domain name for website"
}

variable "certificate" {
  description = "ACM Certificate ARN"
}