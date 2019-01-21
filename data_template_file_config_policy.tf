data "template_file" "config_rules_policy" {
  template = "${file("${path.module}/iam-policy-templates/aws-config-policy.tpl")}"

  vars {
    s3_bucket_name = "config-rules-${data.aws_caller_identity.current.account_id}"
    account_id     = "${data.aws_caller_identity.current.account_id}"
  }
}
