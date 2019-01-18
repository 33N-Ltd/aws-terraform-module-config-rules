variable "account_name" {}

variable "config_logs_bucket" {
  description = "The S3 bucket for AWS Config logs."
  type        = "string"
}

variable "config_logs_prefix" {
  description = "The S3 prefix for AWS Config logs."
  default     = "config"
  type        = "string"
}

variable "config_max_execution_frequency" {
  description = "The maximum frequency with which AWS Config runs evaluations for a rule."
  default     = "TwentyFour_Hours"
  type        = "string"
}

variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = "string"
}

variable "acm_days_to_expiration" {
  description = "Specify the number of days before the rule flags the ACM Certificate as noncompliant."
  default     = 14
}

variable "password_require_uppercase" {
  description = "Require at least one uppercase character in password."
  default     = true
}

variable "password_require_lowercase" {
  description = "Require at least one lowercase character in password."
  default     = true
}

variable "password_require_symbols" {
  description = "Require at least one symbol in password."
  default     = true
}

variable "password_require_numbers" {
  description = "Require at least one number in password."
  default     = true
}

variable "password_min_length" {
  description = "Password minimum length."
  default     = 14
}

variable "password_reuse_prevention" {
  description = "Number of passwords before allowing reuse."
  default     = 24
}

variable "password_max_age" {
  description = "Number of days before password expiration."
  default     = 90
}

// require-tags
variable "tag_value_1" {
  description = "resource tag."
  default     = ""
}

variable "tag_value_2" {
  description = "resource tag."
  default     = ""
}

variable "tag_value_3" {
  description = "resource tag."
  default     = ""
}

// restricted-common-ports
variable "blockedPort1" {
  description = "Blocked TCP port number."
  default     = ""
}

variable "blockedPort2" {
  description = "Blocked TCP port number."
  default     = ""
}

variable "blockedPort3" {
  description = "Blocked TCP port number."
  default     = ""
}

variable "blockedPort4" {
  description = "Blocked TCP port number."
  default     = ""
}

variable "blockedPort5" {
  description = "Blocked TCP port number."
  default     = ""
}

variable "common_tags" {
  type = "map"
}

locals {
}