resource "aws_iam_role" "local_config_rules" {
  name               = "AWS-CONFIG-LOCAL-${upper(var.account_name)}-ROLE"
  description        = "Managed by Terraform"
  assume_role_policy = data.aws_iam_policy_document.aws-config-role-policy.json
}

