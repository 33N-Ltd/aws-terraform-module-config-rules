data "template_file" "config_rules_bucket_policy" {
  template = "${file("${path.module}/iam-policy-templates/s3_config_rules_bucket_policy.json")}"

  vars {
    s3_bucket_name = "config-rules-${data.aws_caller_identity.current.account_id}"
    account_id     = "${data.aws_caller_identity.current.account_id}"
  }
}
