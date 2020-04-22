data "aws_route53_zone" "zone01" {
  name         = "cloudmaniacs.de"
  private_zone = false
}
data "aws_route53_zone" "zone02" {
  name         = "cloud-maniacs.de"
  private_zone = false
}

resource "aws_route53_record" "validate-zone01" {
  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone01.id
  records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

resource "aws_route53_record" "validate-zone02" {
  name    = aws_acm_certificate.cert.domain_validation_options.1.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.1.resource_record_type
  zone_id = data.aws_route53_zone.zone02.id
  records = [aws_acm_certificate.cert.domain_validation_options.1.resource_record_value]
  ttl     = 60
}


resource "aws_route53_record" "cloudmaniacs-website" {
  zone_id = data.aws_route53_zone.zone01.id
  name    = "cloudmaniacs.de"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudmaniacs-website.domain_name
    zone_id                = aws_cloudfront_distribution.cloudmaniacs-website.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "STAR_cloudmaniacs-redirect" {
  zone_id = data.aws_route53_zone.zone01.id
  name    = "*.cloudmaniacs.de"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudmaniacs-redirect.domain_name
    zone_id                = aws_cloudfront_distribution.cloudmaniacs-redirect.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "STAR_cloud-maniacs-redirect" {
  zone_id = data.aws_route53_zone.zone02.id
  name    = "*.cloud-maniacs.de"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudmaniacs-redirect.domain_name
    zone_id                = aws_cloudfront_distribution.cloudmaniacs-redirect.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cloud-maniacs-redirect" {
  zone_id = data.aws_route53_zone.zone02.id
  name    = "cloud-maniacs.de"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cloudmaniacs-redirect.domain_name
    zone_id                = aws_cloudfront_distribution.cloudmaniacs-redirect.hosted_zone_id
    evaluate_target_health = true
  }
}