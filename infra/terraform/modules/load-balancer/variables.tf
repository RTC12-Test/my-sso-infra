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
variable "aws_lb_type" {
  description = "The type of load Balancer to create. Possible values are application, gateway, or network. The default value is application"
  type        = string
  default     = ""
}
variable "aws_nlb_vpc_subnet" {
  description = "A list of subnet IDs to attach to the LB. For Load Balancers of type network subnets can only be added, deleting a subnet for load balancers of type network will force a recreation of the resource"
  type        = list(string)
  default     = [""]
}
variable "aws_nlb_sg_id" {
  description = "A list of Security Group IDs to assign to the LB. Only valid for Load Balancers of type application or network"
  type        = list(string)
  default     = [""]
}
variable "aws_nlb_internal" {
  description = "If true, the LB will be internal. Defaults to false"
  type        = bool
  default     = true
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "aws_nlb_port" {
  description = "Port on which the load Balancer is listening. Not valid for Gateway Load Balancers"
  type        = number
  default     = 0
}
variable "aws_nlb_protocol" {
  description = "(May be required, Forces new resource) Protocol to use for routing traffic to the targets. Should be one of GENEVE, HTTP, HTTPS, TCP, TCP_UDP, TLS, or UDP. Required when target_type is instance, ip, or alb. Does not apply when target_type is lambda"
  type        = string
  default     = "TLS"
}
variable "aws_nlb_routing_type" {
  description = "Type of routing action"
  type        = string
  default     = "forward"
}
variable "aws_enable_deletion_protection" {
  description = "If true, deletion of the load Balancer will be disabled via the AWS API"
  type        = bool
  default     = false
}
variable "aws_vpc_id" {
  description = "Identifier of the VPC in which to create the target group. Required when target_type is instance, ip or alb"
  type        = string
  default     = ""
}
variable "aws_lb_target_group_port" {
  description = "The port the load Balancer uses when performing health checks on targets"
  type        = number
  default     = 0
}
variable "aws_lb_target_group_protocal" {
  description = "Protocol the load Balancer uses when performing health checks on targets. Must be one of TCP, HTTP, or HTTPS"
  type        = string
  default     = "TLS"
}
variable "aws_lb_target_group_type" {
  description = "Type of target that you must specify when registering targets with this target group"
  type        = string
  default     = "ip"
}
variable "aws_lb_target_group_health_path_green" {
  description = "Destination for the health check request. Required for HTTP/HTTPS ALB and HTTP NLB. Only applies to HTTP/HTTPS"
  type        = string
  default     = ""
}
variable "aws_lb_target_group_health_path_blue" {
  description = "Destination for the health check request. Required for HTTP/HTTPS ALB and HTTP NLB. Only applies to HTTP/HTTPS"
  type        = string
  default     = ""
}
variable "aws_lb_target_group_health_port_green" {
  description = "The port the load Balancer uses when performing health checks on targets. Valid values are either traffic-port, to use the same port as the target group, or a valid port number between 1 and 65536. Default is traffic-port"
  type        = string
  default     = ""
}
variable "aws_lb_target_group_health_port_blue" {
  description = "The port the load Balancer uses when performing health checks on targets. Valid values are either traffic-port, to use the same port as the target group, or a valid port number between 1 and 65536. Default is traffic-port"
  type        = string
  default     = ""
}
variable "aws_active_target_group" {
  description = "Whether to use the blue target group or green target group"
  type        = string
  default     = ""
}
variable "aws_load_balancing_cross_zone_enabled" {
  description = "Indicates whether cross zone load balancing is enabled"
  type        = bool
  default     = true
}
variable "service_name" {
  description = "Service name"
  type        = string
  default     = ""
}
variable "aws_enable_cross_zone_load_balancing" {
  description = "If true, cross-zone load balancing of the load Balancer will be enabled"
  type        = bool
  default     = true
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "aws_acm_cerficate_arn" {
  description = "The ARN of the certificate to attach to the listener"
  type        = string
  default     = ""
}
variable "aws_lb_target_group_health_protocol" {
  description = "Protocol the load Balancer uses when performing health checks on targets. Must be one of TCP, HTTP, or HTTPS. The TCP protocol is not supported for health checks if the protocol of the target group is HTTP or HTTPS. Default is HTTP. Cannot be specified when the target_type is lambda"
  type        = string
  default     = "HTTPS"
}
