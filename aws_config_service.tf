module "config_bucket" {
  source = "git::https://github.com/osodevops/aws-terraform-module-s3.git?ref=NHS-140-TF-VER-Update"

  //source                  = "git::ssh://git@github.com/osodevops/aws-terraform-module-s3.git"
  s3_bucket_name          = "config-rules-${data.aws_caller_identity.current.account_id}"
  s3_bucket_policy        = data.template_file.config_rules_bucket_policy.rendered
  s3_bucket_force_destroy = var.s3_bucket_force_destroy
  common_tags             = var.common_tags
}

/**
 * AWS Config Service
 */
resource "aws_config_configuration_recorder_status" "main" {
  name       = "aws-config"
  is_enabled = true
  depends_on = [aws_config_delivery_channel.main]
}

resource "aws_config_delivery_channel" "main" {
  name           = "aws-config"
  s3_bucket_name = "config-rules-${data.aws_caller_identity.current.account_id}"

  snapshot_delivery_properties {
    delivery_frequency = var.config_delivery_frequency
  }

  depends_on = [aws_config_configuration_recorder.main]
}

resource "aws_config_configuration_recorder" "main" {
  name     = "aws-config"
  role_arn = aws_iam_role.local_config_rules.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

