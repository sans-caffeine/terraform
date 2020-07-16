//Configuration for www redirect domain
resource "aws_s3_bucket" "bucket" {
  bucket = "www.${var.domain}"
  acl    = "private"

	website {
		redirect_all_requests_to = var.domain
	}
}

locals {
	s3_bucket_origin_id = "S3-Website-${aws_s3_bucket.bucket.website_endpoint}"
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls   = true
  block_public_policy = true
	ignore_public_acls = true 
	restrict_public_buckets = true 
}

resource "aws_cloudfront_distribution" "cloudfront" {

  origin {
  	domain_name = aws_s3_bucket.bucket.website_endpoint
		origin_id   = local.s3_bucket_origin_id
    custom_origin_config {
      http_port                = 80 
      https_port               = 443 
      origin_keepalive_timeout = 5 
      origin_protocol_policy   = "http-only" 
      origin_read_timeout      = 30 
      origin_ssl_protocols     = ["TLSv1","TLSv1.1","TLSv1.2"] 
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "www.${var.domain}"

	aliases = ["www.${var.domain}"]

	viewer_certificate {
		acm_certificate_arn = var.certificate.certificate_arn
		minimum_protocol_version = "TLSv1.1_2016" 
  	ssl_support_method = "sni-only"
	}

 	default_cache_behavior {
  	allowed_methods  = ["GET", "HEAD"]
  	cached_methods   = ["GET", "HEAD"]
		target_origin_id = local.s3_bucket_origin_id 

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
		compress 							 = false
	}

	restrictions {
    geo_restriction {
			restriction_type = "none"
  //    restriction_type = "whitelist"
  //    locations        = ["GB"]
    }
	}
}
