resource "aws_s3_bucket" "bucket" {
  bucket = "${var.name}.${var.domain}"
  acl    = "private"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true 
  restrict_public_buckets = true 
}
