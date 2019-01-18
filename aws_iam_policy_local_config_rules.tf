resource "aws_iam_policy" "local_config_rules" {
  name        = "AWS-CONFIG-${upper(var.account_name)}-POLICY"
  description = "Managed by Terraform: Policy used in trust relationship with AWS Config"
  path = "/service-role/"
  policy = "${data.aws_iam_policy_document.lo.json}"
}
