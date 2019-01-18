resource "aws_iam_role_policy_attachment" "local_config_rules" {
  role       = "${aws_iam_role.local_config_rules.name}"
  policy_arn = "${aws_iam_policy.config_service_delivery_permission.arn}"
}
