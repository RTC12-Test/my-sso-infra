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
variable "service_name" {
  description = "The service assign for the security should create"
  type        = string
  default     = ""
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "aws_sercret_string" {
  description = "Specifies text data that you want to encrypt and store in this version of the secret. This is required if secret_binary is not set"
  type        = any
  default     = null
}

