# Route 53 and sub-domain name setup

resource "aws_route53_zone" "myapp-domain-name" {
  name = "webapp.mathidaduku.me"
}

resource "aws_route53_zone" "sockshop-domain-name" {
  name = "sockshop.mathidaduku.me"
}

# create SSL certificate 
resource "aws_acm_certificate" "ssl" {
  domain_name               = "sockshop.mathidaduku.me"
  subject_alternative_names = ["*.sockshop.mathidaduku.me"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

## create DNS record for ACM certificate
resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.ssl.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.sockshop-domain-name.id
  ttl             = 60
}

## Validates ACM certificate
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.ssl.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

# create SSL certificate 
resource "aws_acm_certificate" "sslb" {
  domain_name               = "sockshop.mathidaduku.me"
  subject_alternative_names = ["*.sockshop.mathidaduku.me"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

## create DNS record for ACM certificate
resource "aws_route53_record" "cert_validationb" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.sslb.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.sslb.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.sslb.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.myapp-domain-name.id
  ttl             = 60
}

## Validates ACM certificate
resource "aws_acm_certificate_validation" "certb" {
  certificate_arn         = aws_acm_certificate.sslb.arn
  validation_record_fqdns = [aws_route53_record.cert_validationb.fqdn]
}

# Get the zone_id for the load balancer

data "aws_elb_hosted_zone_id" "load_balancer_zone_id" {
  depends_on = [
    kubernetes_service.kube-voting-service, kubernetes_service.k8s-service-sockshop
  ]
}

# DNS record for portfolio

# resource "aws_route53_record" "myapp-dns-record" {
#   zone_id = aws_route53_zone.myapp-domain-name.zone_id
#   name    = "webapp.mathidaduku.me"
#   type    = "A"

#   alias {
#     name                   = kubernetes_service.kube-voting-service.status.0.load_balancer.0.ingress.0.hostname
#     zone_id                = data.aws_elb_hosted_zone_id.load_balancer_zone_id.id
#     evaluate_target_health = true
#   }
# }

# DNS record for socks

resource "aws_route53_record" "sockshop-dns-record" {
  zone_id = aws_route53_zone.sockshop-domain-name.zone_id
  name    = "sockshop.mathidaduku.me"
  type    = "A"

  alias {
    name                   = kubernetes_service.k8s-service-sockshop.status.0.load_balancer.0.ingress.0.hostname
    zone_id                = data.aws_elb_hosted_zone_id.load_balancer_zone_id.id
    evaluate_target_health = true
  }
}