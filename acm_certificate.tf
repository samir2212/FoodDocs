resource "aws_acm_certificate" "fooddocs" {
  domain_name       = "fooddocs.com"
  validation_method = "DNS"

  tags = {
    Name = "fooddocs.com"
  }

  subject_alternative_names = [
    "*.fooddocs.com",
  ]

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}
