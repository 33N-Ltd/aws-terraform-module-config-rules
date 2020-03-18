data "template_file" "aws_config_ami_approved_tag" {
  template = file(
    "${path.module}/config-policy-templates/ami-approved-tag.tpl",
  )

  vars = {
    ami_tagKey_tagValue = var.ami_tagKey_tagValue
  }
}

