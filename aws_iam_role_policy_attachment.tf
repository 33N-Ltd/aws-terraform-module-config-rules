resource "aws_iam_policy" "aws-config-policy" {
  name   = "aws-config-policy"
  policy = "${data.template_file.config_rules_policy.rendered}"
}

resource "aws_iam_policy_attachment" "aws-config-policy" {
  name       = "aws-config-policy"
  roles      = ["${aws_iam_role.local_config_rules.name}"]
  policy_arn = "${aws_iam_policy.aws-config-policy.arn}"
}

resource "aws_iam_policy_attachment" "managed-policy" {
  name       = "aws-config-managed-policy"
  roles      = ["${aws_iam_role.local_config_rules.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
}