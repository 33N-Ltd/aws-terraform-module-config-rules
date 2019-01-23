data "template_file" "config_required_tag_name_policy" {
  template = "${file("${path.module}/config-policy-templates/required-tag-name.tpl")}"
}

data "template_file" "config_required_technical_tags_policy" {
  template = "${file("${path.module}/config-policy-templates/required-tags-technical.tpl")}"
}

data "template_file" "config_required_operational_tags_policy" {
  template = "${file("${path.module}/config-policy-templates/required-tags-operational.tpl")}"
}

data "template_file" "config_required_business_tags_policy" {
  template = "${file("${path.module}/config-policy-templates/required-tags-business.tpl")}"
}
