resource "aws_acm_certificate" "cert" {
  domain_name       = "cloudmaniacs.de"
  subject_alternative_names = ["*.cloudmaniacs.de", "cloud-maniacs.de", "*.cloud-maniacs.de" ]
  validation_method = "DNS"
  provider = aws.virginia
  lifecycle {
    create_before_destroy = true
    ignore_changes = [subject_alternative_names]
  }
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [ aws_route53_record.validate-zone01.fqdn, aws_route53_record.validate-zone02.fqdn ]
  provider = aws.virginia
}