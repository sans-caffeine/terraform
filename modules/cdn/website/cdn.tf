locals {
  s3_public_origin_id = "S3-${var.public_bucket.bucket}"
}

resource "aws_cloudfront_origin_access_identity" "S3_public_origin_access_identity" {
  comment = "access-identity-${var.public_bucket.bucket}.s3.amazonaws.com"
}

data "aws_iam_policy_document" "s3_public_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${var.public_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.S3_public_origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = var.public_bucket.id
  policy = data.aws_iam_policy_document.s3_public_policy.json

  depends_on = [var.public_bucket_access_block]
}

resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = var.public_bucket.bucket_domain_name
    origin_id   = local.s3_public_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.S3_public_origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  comment             = var.domain

  viewer_certificate {
    cloudfront_default_certificate = true 
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_public_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress = true
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
    error_caching_min_ttl = 300 
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
    error_caching_min_ttl = 300 
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_All"
}

