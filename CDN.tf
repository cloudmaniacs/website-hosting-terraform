# cloudmanics.de CDN Domain
resource "aws_cloudfront_distribution" "cloudmaniacs-website" {
  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["cloudmaniacs.de"]
  price_class     = "PriceClass_100"

  #### The origin that points to S3
  origin {
    domain_name = aws_s3_bucket.cloudmaniacs-website.website_endpoint
    origin_id   = aws_s3_bucket.cloudmaniacs-website.id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

  }
  
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.cloudmaniacs-website.id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    default_ttl = 86400
    max_ttl     = 86400
    min_ttl     = 86400
    compress    = true
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  depends_on = [ aws_s3_bucket.cloudmaniacs-website ]
}

# catch-all CDN Domain
resource "aws_cloudfront_distribution" "cloudmaniacs-redirect" {
  enabled         = true
  is_ipv6_enabled = true
  aliases         = ["*.cloudmaniacs.de","*.cloud-maniacs.de","cloud-maniacs.de"]
  price_class     = "PriceClass_100"

  #### The origin that points to S3
  origin {
    domain_name = aws_s3_bucket.cloudmaniacs-redirect.website_endpoint
    origin_id   = aws_s3_bucket.cloudmaniacs-redirect.id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

  }
  

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.cloudmaniacs-redirect.id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    default_ttl = 86400
    max_ttl     = 86400
    min_ttl     = 86400
    compress    = true
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  depends_on = [ aws_s3_bucket.cloudmaniacs-redirect ]
}