variable "domain" {
  type = string
  description = "The domain for the website"
}

variable "public_bucket" {
  description = "The storage bucket to be used for the public files"
}

variable "public_bucket_access_block" {
  description = "The public storage bucket public access block"
}