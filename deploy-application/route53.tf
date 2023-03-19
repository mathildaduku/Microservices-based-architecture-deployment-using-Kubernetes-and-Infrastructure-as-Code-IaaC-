
resource "aws_route53_zone" "myapp-domain-name" {
  name = "webapp.mathidaduku.me"
}

resource "aws_route53_zone" "sockshop-domain-name" {
  name = "sockshop.mathidaduku.me"
}


data "aws_elb_hosted_zone_id" "load_balancer_zone_id" {
  depends_on = [
    kubernetes_service.kube-voting-service, kubernetes_service.k8s-service-sockshop
  ]
}



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