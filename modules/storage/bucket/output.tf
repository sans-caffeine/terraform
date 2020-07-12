output "bucket" {
  value = aws_s3_bucket.bucket
}

output "public_access_block" {
  value = aws_s3_bucket_public_access_block.bucket
}