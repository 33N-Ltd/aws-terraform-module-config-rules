resource "aws_iam_policy" "config_service_delivery_permission" {
  name        = "AWS-CONFIG-${upper(var.account_name)}-POLICY"
  description = "Managed by Terraform: Allow AWS Config to delivery logs"
  path = "/service-role/"
  policy = "${data.aws_iam_policy_document.forrole.json}"
}
