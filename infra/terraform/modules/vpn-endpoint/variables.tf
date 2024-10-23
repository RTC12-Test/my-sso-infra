variable "aws_vpc_id" {
  description = "Identifier of the VPC in which to create the target group. Required when target_type is instance, ip or alb"
  type        = string
  default     = ""
}
variable "aws_vpc_endpoint_subnet" {
  description = "A list of subnet IDs to attach to the LB. For Load Balancers of type network subnets can only be added, deleting a subnet for load balancers of type network will force a recreation of the resource"
  type        = list(string)
  default     = [""]
}
variable "aws_vpc_endpoint_service_name" {
  description = "The service name. For AWS services the service name is usually in the form com.amazonaws.<region>.<service> (the SageMaker Notebook service is an exception to this rule, the service name is in the form"
  type        = string
  default     = ""
}
variable "aws_vpc_endpoint_type" {
  description = "The VPC endpoint type, Gateway, GatewayLoadBalancer, or Interface. Defaults to Gateway"
  type        = string
  default     = "Interface"
}
variable "aws_vpc_endpoint_sg_ids" {
  description = ""
  type        = list(string)
  default     = [""]
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "env" {
  description = "Environment"
  type        = string
  default     = ""
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
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
