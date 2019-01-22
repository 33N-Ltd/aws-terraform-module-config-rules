data "template_file" "config_required_tags_policy" {
  template = "${file("${path.module}/config-policy-templates/rule-required-tags-policy.tpl")}"

  vars = {
    tagValue1 = "${var.tag_value_1}"
    tagValue2 = "${var.tag_value_2}"
    tagValue3 = "${var.tag_value_3}"

  }
}