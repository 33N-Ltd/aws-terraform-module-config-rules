data "template_file" "aws_config_acm_certificate_expiration" {
  template = "${file("${path.module}/config-policy-templates/acm-certificate-expiration.tpl")}"

  vars = {
    acm_days_to_expiration = "${var.acm_days_to_expiration}"
  }
}
