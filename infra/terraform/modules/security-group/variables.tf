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
variable "aws_vpc_id" {
  description = "Defaults to the region's default VPC"
  type        = string
  default     = ""
}
variable "aws_sg_ingress_protocal" {
  description = "Protocol. If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from_port and to_port equal to 0"
  type        = string
  default     = "tcp"
}
variable "aws_sg_egress_protocal" {
  description = "Protocol. If you select a protocol of -1 (semantically equivalent to all, which is not a valid value here), you must specify a from_port and to_port equal to 0"
  type        = string
  default     = "tcp"
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "aws_sg_configuration" {
  description = "Map of Security Groups which contain Ingress rules and Egress rules"
  type        = any
  default     = null
}
