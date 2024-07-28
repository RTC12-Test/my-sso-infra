variable "aws_repository_image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`."
  type        = string
  default     = "MUTABLE"
}
variable "aws_repository_encryption_type" {
  description = "The encryption type for the repository. Must be one of: `KMS` or `AES256`. Defaults to `AES256`"
  type        = string
  default     = "KMS"
}
variable "aws_repository_kms_key" {
  description = "The ARN of the KMS key to use when encryption_type is `KMS`. If not specified, uses the default AWS managed key for ECR"
  type        = string
  default     = null
}
variable "aws_repository_force_delete" {
  description = "If `true`, will delete the repository even if it contains images. Defaults to `false`"
  type        = bool
  default     = "false"
}
variable "app_name" {
  description = "Application name"
  type        = string
  default     = ""
}
variable "org_name" {
  description = "Organization name"
  type        = string
  default     = ""
}
variable "env" {
  description = "Environment"
  type        = string
  default     = ""
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "aws_scanning_configuration" {
  description = "Indicates whether images are scanned after being pushed to the repository (`true`) or not scanned (`false`)"
  type        = bool
  default     = true
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "service_name" {
  description = "Service name"
  type        = string
  default     = ""
}
variable "enable_ecr_scanning" {
  description = "Flag to create ecr repository"
  type        = bool
  default     = true
}
variable "aws_ecr_scan_type" {
  description = "The scanning type to set for the registry. Can be either ENHANCED or BASIC"
  type        = string
  default     = "ENHANCED"
}
variable "aws_ecr_scan_frequency" {
  description = "The frequency that scans are performed at for a private registry. Can be SCAN_ON_PUSH, CONTINUOUS_SCAN, or MANUAL"
  type        = string
  default     = "SCAN_ON_PUSH"
}
variable "aws_ecr_scan_filter" {
  description = "String filtering repositories.Uses regex"
  type        = string
  default     = ""
}
variable "aws_ecr_scan_filter_type" {
  description = "Currently only WILDCARD is supported"
  type        = string
  default     = "WILDCARD"
}
