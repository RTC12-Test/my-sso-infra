variable "org_name" {
  description = "Organization name"
  type        = string
  default     = ""
}
variable "app_name" {
  description = "Application name"
  type        = string
  default     = ""
}
variable "env" {
  description = "Environment"
  type        = string
  default     = ""
}
variable "service_name" {
  description = "Service name"
  type        = string
  default     = ""
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "create_aws_s3_bucket_policy" {
  description = "Flag to control the creation of the bucket policy"
  type        = bool
  default     = false
}
variable "aws_account_id" {
  description = "The AWS account ID for Elastic Load Balancing"
  type        = string
  default     = ""
}
variable "aws_s3_bucket_policy" {
  description = "The JSON-encoded policy to apply to the S3 bucket"
  type        = string
  default     = ""
}