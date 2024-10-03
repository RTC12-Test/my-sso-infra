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
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "aws_lb_tg_port" {
  description = "The port the load balancer uses when performing health checks on targets"
  type        = number
  default     = 443
}
variable "aws_lb_tg_protocal" {
  description = "Protocol the load balancer uses when performing health checks on targets. Must be one of TCP, HTTP, or HTTPS"
  type        = string
  default     = "HTTPS"
}
variable "aws_lb_tg_type" {
  description = "Type of target that you must specify when registering targets with this target group"
  type        = string
  default     = "ip"
}
variable "aws_lb_tg_health_path" {
  description = "Destination for the health check request. Required for HTTP/HTTPS ALB and HTTP NLB. Only applies to HTTP/HTTPS"
  type        = string
  default     = ""
}
variable "aws_lb_tg_health_port" {
  description = "The port the load balancer uses when performing health checks on targets. Valid values are either traffic-port, to use the same port as the target group, or a valid port number between 1 and 65536. Default is traffic-port"
  type        = string
  default     = "traffic-port"
}
variable "aws_lb_tg_health_protocol" {
  description = "Protocol the load balancer uses when performing health checks on targets. Must be one of TCP, HTTP, or HTTPS. The TCP protocol is not supported for health checks if the protocol of the target group is HTTP or HTTPS. Default is HTTP. Cannot be specified when the target_type is lambda"
  type        = string
  default     = "HTTPS"
}
variable "aws_lb_tg_healthy_threshold" {
  description = "Number of consecutive health check successes required before considering a target healthy. The range is 2-10. Defaults to 3"
  type        = number
  default     = 5
}
variable "aws_lb_tg_unhealthy_threshold" {
  description = "Number of consecutive health check successes required before considering a target healthy. The range is 2-10. Defaults to 3"
  type        = number
  default     = 2
}
variable "aws_lb_tg_stickness_enabled" {
  description = "Boolean to enable / disable stickiness. Default is true."
  type        = bool
  default     = false
}
variable "aws_lb_tg_stickeness_type" {
  description = "The type of sticky sessions. The only current possible values are lb_cookie, app_cookie for ALBs, source_ip for NLBs, and source_ip_dest_ip, source_ip_dest_ip_proto for GWLBs"
  type        = string
  default     = "lb_cookie"
}
variable "aws_vpc_id" {
  description = "Identifier of the VPC in which to create the target group. Required when target_type is instance, ip or alb"
  type        = string
  default     = ""
}
variable "enable_stickness" {
  description = "value"
  type        = bool
  default     = false
}
variable "aws_lb_tg_service_name" {
  description = "Name of the target group. If omitted, Terraform will assign a random, unique name. This name must be unique per region per account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen"
  type        = string
  default     = ""
}
variable "aws_lb_tg_cookie_duration" {
  description = "value"
  type        = number
  default     = 1800
}
