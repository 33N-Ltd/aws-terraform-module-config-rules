resource "aws_iam_role_policy_attachment" "local_config_rules" {
  role       = "${aws_iam_role.local_config_rules.name}"
  policy_arn = "${aws_iam_policy.config_service_delivery_permission.arn}"
}

resource "aws_iam_policy" "aws-config-policy" {
  name   = "aws-config-policy"
  policy = "${data.template_file.config_rules_policy.rendered}"
}

resource "aws_iam_policy_attachment" "aws-config-policy" {
  name       = "aws-config-policy"
  roles      = ["${aws_iam_role.local_config_rules.name}"]
  policy_arn = "${aws_iam_policy.aws-config-policy.arn}"
}