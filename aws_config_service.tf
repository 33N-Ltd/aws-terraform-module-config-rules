module "config_bucket" {
  source                  = "git::ssh://git@github.com/osodevops/aws-terraform-module-s3.git"
  s3_bucket_name          = "config-rules-${data.aws_caller_identity.current.account_id}"
  s3_bucket_policy        = "${data.template_file.config_rules_bucket_policy.rendered}"
  s3_bucket_force_destroy = "${var.s3_bucket_force_destroy}"
  common_tags             = "${var.common_tags}"
  //todo: fixed the service side encryption on bucket.
}

resource "aws_config_configuration_recorder_status" "recorder_status" {
  name       = "AWS-CONFIG-RECORDER-STATUS-${upper(var.account_name)}"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.delivery_channel"]
}

resource "aws_config_delivery_channel" "delivery_channel" {
  name       = "AWS-CONFIG-DELIVERY-CHANNEL-${upper(var.account_name)}"
  s3_bucket_name = "config-rules-${data.aws_caller_identity.current.account_id}"

  snapshot_delivery_properties = {
    delivery_frequency = "${var.config_delivery_frequency}"
  }

  depends_on = ["aws_config_configuration_recorder.recorder"]
}

resource "aws_config_configuration_recorder" "recorder" {
  name       = "AWS-CONFIG-RECORDER-${upper(var.account_name)}"
  role_arn = "${aws_iam_role.local_config_rules.arn}"

  recording_group = {
    all_supported                 = true
    include_global_resource_types = true
  }
}