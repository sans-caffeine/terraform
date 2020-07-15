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
		domain_name = var.domain
		origin_id   = "dummy-origin"

		custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "match-viewer"
      origin_read_timeout      = 30
      origin_ssl_protocols     = ["SSLv3", "TLSv1"]
		}
	}

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

	aliases = var.aliases

  viewer_certificate {
		acm_certificate_arn = var.certificate_arn
    cloudfront_default_certificate = var.certificate_arn == null ? true : false 
		minimum_protocol_version = var.certificate_arn == null ? null : "TLSv1.1_2016" // can this be set to TLSv1.1_2016 with default certificate?
  	ssl_support_method = var.certificate_arn == null ? null : "sni-only"           // can this be set to sni-only with default certificate?
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

  dynamic "ordered_cache_behavior" {
    for_each = var.behaviors
    content {
      path_pattern = ordered_cache_behavior.value.path_pattern
      allowed_methods  = ["GET", "HEAD"]
      cached_methods   = ["GET", "HEAD"]
			target_origin_id = ordered_cache_behavior.value.dummy ? "dummy-origin" : local.s3_public_origin_id

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
    	compress               = true

    	lambda_function_association {
      	event_type   = "viewer-request"
      	include_body = false
      	lambda_arn   = ordered_cache_behavior.value.function.qualified_arn
			}
    }
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

