data "template_file" "aws_config_restricted_common_ports" {
  template = file(
    "${path.module}/config-policy-templates/restricted-common-ports.tpl",
  )

  vars = {
    "blockedPort1" = var.blockedPort1
    "blockedPort2" = var.blockedPort2
    "blockedPort3" = var.blockedPort3
    "blockedPort4" = var.blockedPort4
    "blockedPort5" = var.blockedPort5
  }
}

