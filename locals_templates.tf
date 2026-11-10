locals {
  aws_config_acm_certificate_expiration = templatefile("${path.module}/config-policy-templates/acm-certificate-expiration.tpl", {
    acm_days_to_expiration = var.acm_days_to_expiration
  })

  aws_config_ami_approved_tag = templatefile("${path.module}/config-policy-templates/ami-approved-tag.tpl", {
    ami_tagKey_tagValue = var.ami_tagKey_tagValue
  })

  config_rules_bucket_policy = templatefile("${path.module}/iam-policy-templates/s3_config_rules_bucket_policy.json", {
    s3_bucket_name = "config-rules-${data.aws_caller_identity.current.account_id}"
    account_id     = data.aws_caller_identity.current.account_id
  })

  config_rules_policy = templatefile("${path.module}/iam-policy-templates/aws-config-policy.tpl", {
    s3_bucket_name = "config-rules-${data.aws_caller_identity.current.account_id}"
    account_id     = data.aws_caller_identity.current.account_id
  })

  # The config parameters expect "true" or "false", not 1/0.
  aws_config_iam_password_policy = templatefile("${path.module}/config-policy-templates/iam-password-policy.tpl", {
    password_require_uppercase = var.password_require_uppercase ? "true" : "false"
    password_require_lowercase = var.password_require_lowercase ? "true" : "false"
    password_require_symbols   = var.password_require_symbols ? "true" : "false"
    password_require_numbers   = var.password_require_numbers ? "true" : "false"
    password_min_length        = var.password_min_length
    password_reuse_prevention  = var.password_reuse_prevention
    password_max_age           = var.password_max_age
  })

  config_required_tag_name_policy         = file("${path.module}/config-policy-templates/required-tag-name.tpl")
  config_required_technical_tags_policy   = file("${path.module}/config-policy-templates/required-tags-technical.tpl")
  config_required_operational_tags_policy = file("${path.module}/config-policy-templates/required-tags-operational.tpl")
  config_required_business_tags_policy    = file("${path.module}/config-policy-templates/required-tags-business.tpl")

  aws_config_restricted_common_ports = templatefile("${path.module}/config-policy-templates/restricted-common-ports.tpl", {
    blockedPort1 = var.blockedPort1
    blockedPort2 = var.blockedPort2
    blockedPort3 = var.blockedPort3
    blockedPort4 = var.blockedPort4
    blockedPort5 = var.blockedPort5
  })
}
