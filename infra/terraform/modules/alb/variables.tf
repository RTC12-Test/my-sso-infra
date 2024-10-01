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
variable "aws_alb_port" {
  description = "Port on which the load balancer is listening. Not valid for Gateway Load Balancers"
  type        = number
  default     = 0
}
variable "aws_alb_http_port" {
  description = "Port on which the load balancer is listening. Not valid for Gateway Load Balancers"
  type        = string
  default     = 80
}
variable "aws_alb_protocol" {
  description = "Protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are HTTP and HTTPS, with a default of HTTP. For Network Load Balancers"
  type        = string
  default     = "HTTPS"
}
variable "aws_alb_http_protocol" {
  description = "Protocol for connections from clients to the load balancer. For Application Load Balancers, valid values are HTTP and HTTPS, with a default of HTTP. For Network Load Balancers"
  type        = string
  default     = "HTTP"
}
variable "aws_acm_cerficate_arn" {
  description = "The ARN of the certificate to attach to the listener"
  type        = string
  default     = ""
}
variable "aws_alb_routing_type" {
  description = "Type of routing action"
  type        = string
  default     = "forward"
}
variable "aws_alb_load_balancing_cross_zone_enabled" {
  description = "Indicates whether cross zone load balancing is enabled"
  type        = bool
  default     = true
}
variable "aws_alb_internal" {
  description = "If true, the LB will be internal. Defaults to false"
  type        = bool
  default     = true
}
variable "aws_alb_enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
  type        = bool
  default     = false
}
variable "aws_alb_sg_id" {
  description = "A list of security group IDs to assign to the LB. Only valid for Load Balancers of type application or network"
  type        = list(string)
  default     = [""]
}
variable "aws_alb_vpc_subnet" {
  description = "A list of subnet IDs to attach to the LB. For Load Balancers of type network subnets can only be added, deleting a subnet for load balancers of type network will force a recreation of the resource"
  type        = list(string)
  default     = [""]
}
variable "aws_alb_http_routing_type" {
  description = "The type of routing action. Valid values are forward, redirect, fixed-response, authenticate-cognito and authenticate-oidc"
  type        = string
  default     = "redirect"
}
variable "aws_lb_listerner_redirect_port" {
  description = "The port. Specify a value from 1 to 65535 or #{port}"
  type        = number
  default     = 443
}
variable "aws_lb_listener_redirect_protocal" {
  description = "The protocol. Valid values are HTTP, HTTPS, or #{protocol}"
  type        = string
  default     = "HTTPS"
}
variable "aws_lb_listener_redirect_status_code" {
  description = "The HTTP redirect code. The redirect is either permanent (HTTP_301) or temporary (HTTP_302)"
  type        = string
  default     = "HTTP_301"
}
variable "aws_lb_type" {
  description = "The type of load balancer to create. Possible values are application, gateway, or network. The default value is application"
  type        = string
  default     = "application"
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "aws_alb_name" {
  description = "Name of the ALB"
  type        = string
  default     = ""
}
variable "aws_lb_listener_rule_stickness_duration" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target group. The range is 1-604800 seconds (7 days)"
  type        = number
  default     = 3600
}
variable "aws_lb_listener_rule_stickness_enabled" {
  description = "The time period, in seconds, during which requests from a client should be routed to the same target group. The range is 1-604800 seconds (7 days)"
  type        = bool
  default     = false
}
variable "aws_alb_service_name" {
  description = "Service name"
  type        = string
  default     = ""
}
variable "aws_alb_creation_by_tf" {
  description = "The value is true if Terraform will create the resource, and false if the resource will be created by another method"
  type        = bool
  default     = false
}
variable "aws_alb_access_logs_s3_bucket_name" {
  description = "S3 bucket name to store the logs in"
  type        = string
  default     = ""
}
variable "aws_alb_access_logs_prefix" {
  description = "S3 bucket prefix. Logs are stored in the root if not configured"
  type        = string
  default     = ""
}
variable "aws_alb_access_logs_enabled" {
  description = "Boolean to enable / disable access_logs. Defaults to false, even when bucket is specified"
  type        = bool
  default     = true
}
variable "aws_alb_idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle"
  type        = number
  default     = 75
}
variable "enable_codeploy" {
  description = "value"
  type        = bool
  default     = false
}
variable "aws_lb_https_listener_rule_priority" {

}
variable "aws_lb_https_listener_tg_arn" {


}
variable "aws_lb_https_listener_rule_path_value" {

}
variable "aws_lb_https_listener_rule_host_header_value" {

}
variable "aws_hp" {

}
