data "template_file" "config_required_tag_name_policy" {
  template = "${file("${path.module}/config-policy-templates/required-tag-name.tpl")}"
}
