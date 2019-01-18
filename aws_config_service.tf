resource "aws_config_configuration_recorder_status" "recorder_status" {
  name       = "aws-config"
  is_enabled = true
  depends_on = ["aws_config_delivery_channel.delivery_channel"]
}

resource "aws_config_delivery_channel" "delivery_channel" {
  name           = "aws-config"
  s3_bucket_name = "${var.config_logs_bucket}"
  s3_key_prefix  = "${var.config_logs_prefix}"

  snapshot_delivery_properties = {
    delivery_frequency = "${var.config_delivery_frequency}"
  }

  depends_on = ["aws_config_configuration_recorder.recorder"]
}

resource "aws_config_configuration_recorder" "recorder" {
  name     = "aws-config"
  role_arn = "${aws_iam_role.local_config_rules.arn}"

  recording_group = {
    all_supported                 = true
    include_global_resource_types = true
  }
}