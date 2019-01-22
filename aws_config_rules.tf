# =======================
# Details of the RuleSets
# =======================
#
# Please refer to the OSO Base Config Rules document for further information.
# The table below maps the RuleSets and the Rule:
#
# | ---"| ----------------------------------------"| ---------------"|
# |      |                                           | Baseline RuleSet |
# | Id   | Rule Name                                 | by Account       |
# |      |                                           | Classification   |
# | ---"| ----------------------------------------"| ---------------"|
# | 0.1  | approved-amis-by-tag                      | All              |
# | 0.2  | ec2-volume-inuse-check                    | All              |
# | 0.3  | ec2-encrypted-volumes                     | All              |
# | 0.4  | restricted-common-ports                   | All              |
# | 0.5  | restricted-ssh                            | All              |
# | 0.6  | rds-storage-encrypted                     | All              |
# | 0.7  | cloudtrail-enabled                        | All              |
# | 0.8  | required-tags                             | All              |
# | 0.9  | acm-certificate-expiration-check          | All              |
# | 0.10 | iam-password-policy                       | All              |
# | 0.11 | iam-user-group-membership-check           | All              |
# | 0.12 | root-account-mfa-enabled                  | All              |
# | 0.13 | s3-bucket-public-write-prohibited         | All              |
# | ---"| ----------------------------------------"| ---------------"|

#==================================================
# 0.1	Checks whether running instances are using specified AMIs.
#==================================================
resource "aws_config_config_rule" "approved-amis-by-tag" {
  name = "approved-amis-by-tag"
  description = "Managed by Terraform: Checks whether running instances are using specified AMIs. Running instances that dont have at least one of the specified tags are noncompliant"
  input_parameters = "${data.template_file.aws_config_ami_approved_tag.rendered}"

  source {
    owner = "AWS"
    source_identifier = "APPROVED_AMIS_BY_TAG"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.2	Ensure EBS volumes are atteched to an EC2 Instance
#==================================================
resource "aws_config_config_rule" "ec2-volume-inuse-check" {
  name = "ec2-volume-inuse-check"
  description = "Managed by Terraform: Checks whether EBS volumes are attached to EC2 instances"

  source {
    owner = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.3	Ensure EBS volumes that are in an attached state are encrypted.
#==================================================
resource "aws_config_config_rule" "ec2-encrypted-volumes" {
  name = "ec2-volumes-must-be-encrypted"
  description = "Managed by Terraform: Evaluates whether EBS volumes that are in an attached state are encrypted. Optionally, you can specify the ID of a KMS key to use to encrypt the volume."

  source {
    owner = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

#========================================== ========
# 0.4	Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports.
#==================================================
resource "aws_config_config_rule" "restricted-common-ports" {
  name = "restricted-common-ports"
  description = "Managed by Terraform: Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports."
  input_parameters = "${data.template_file.aws_config_restricted_common_ports.rendered}"

  source {
    owner = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.5	Restrict SSH accessv via security groups.
#==================================================
resource "aws_config_config_rule" "restricted-ssh" {
  name = "restricted-ssh"
  description = "Managed by Terraform: Checks whether security groups that are in use disallow unrestricted incoming SSH traffic."

  source {
    owner = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.6	Ensure RDS volume is encrypted.
#==================================================
resource "aws_config_config_rule" "rds-storage-encrypted" {
  name = "rds-storage-encrypted"
  description = "Managed by Terraform: Checks whether storage encryption is enabled for your RDS DB instances."

  source {
    owner = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.7	Ensure CloudTrail is enabled.
#==================================================
resource "aws_config_config_rule" "cloudtrail-enabled" {
  name = "cloudtrail-enabled"
  description = "Managed by Terraform: Ensure CloudTrail is enabled"

  source {
    owner = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }

  maximum_execution_frequency = "${var.config_max_execution_frequency}"

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.8.A Ensure Name taga are present on dependent resources
#==================================================
resource "aws_config_config_rule" "required-tag-name" {
  name = "required-tag-name"
  description = "Checks whether your resources have the Name tag that you specify."

  input_parameters = "${data.template_file.config_required_tag_name_policy.rendered}"

  source {
    owner = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  scope {
    compliance_resource_types = [
      "AWS::EC2::CustomerGateway",
      "AWS::EC2::Instance",
      "AWS::EC2::InternetGateway",
      "AWS::EC2::NetworkAcl",
      "AWS::EC2::RouteTable",
      "AWS::EC2::SecurityGroup",
      "AWS::EC2::Subnet",
      "AWS::EC2::Volume",
      "AWS::EC2::VPC",
      "AWS::EC2::VPNConnection",
      "AWS::EC2::VPNGateway",
      "AWS::ACM::Certificate",
      "AWS::RDS::DBInstance",
      "AWS::RDS::DBSecurityGroup",
      "AWS::RDS::DBSnapshot",
      "AWS::RDS::DBSubnetGroup",
      "AWS::RDS::EventSubscription",
      "AWS::S3::Bucket",
    ]
  }
  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.9 ACM Certificates Expiry notificaiton
#==================================================
resource "aws_config_config_rule" "acm-certificate-expiration-check" {
  name = "acm-certificate-expiration-check"
  description = "Managed by Terraform: Checks whether ACM Certificates in your account are marked for expiration within the specified number of days."
  input_parameters = "${data.template_file.aws_config_acm_certificate_expiration.rendered}"

  source {
    owner = "AWS"
    source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }

  maximum_execution_frequency = "${var.config_max_execution_frequency}"

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.10 Enforce password policy on all users
#==================================================
resource "aws_config_config_rule" "iam-password-policy" {
  name = "iam-password-policy"
  description = "Managed by Terraform: Ensure the account password policy for IAM users meets the specified requirements"
  input_parameters = "${data.template_file.aws_config_iam_password_policy.rendered}"

  source {
    owner = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }

  maximum_execution_frequency = "${var.config_max_execution_frequency}"
  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.11 Ensure IAM user is a member of at least 1 IAM group / role
#==================================================
resource "aws_config_config_rule" "iam-user-no-policies-check" {
  name = "iam-user-no-policies-check"
  description = "Managed by Terraform: Ensure that none of your IAM users have policies attached. IAM users must inherit permissions from IAM groups or roles."

  source {
    owner = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.12	Ensure the MFA is enaled on all root accounts.
#==================================================
resource "aws_config_config_rule" "root-account-mfa-enabled" {
  name = "root-account-mfa-enabled"
  description = "Managed by Terraform: Ensure root AWS account has MFA enabled"

  source {
    owner = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  maximum_execution_frequency = "${var.config_max_execution_frequency}"

  depends_on = ["aws_config_configuration_recorder.main"]
}

#==================================================
# 0.13	Ensure that your Amazon S3 buckets do not allow public write access.
#==================================================
resource "aws_config_config_rule" "s3-public-bucket-not-writable" {
  name = "s3-public-bucket-not-writable"
  description = "Managed by Terraform: Checks that your Amazon S3 buckets do not allow public write access."

  source {
    owner = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

  depends_on = ["aws_config_configuration_recorder.main"]
}