variable "aws_lb_listener_arn" {
  description = "(Required, Forces New Resource) The ARN of the listener to which to attach the rule"
  type        = string
  default     = ""
}
variable "aws_lb_routing_rule_type" {
  description = "Type of routing action"
  type        = string
  default     = "forward"
}
variable "aws_lb_https_listener_tg_arn" {
  description = "ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead. Cannot be specified with forward"
  type        = string
  default     = ""
}
variable "aws_lb_https_path_values" {
  description = "(Required) List of header value patterns to match. Maximum size of each pattern is 128 characters. Comparison is case insensitive. Wildcard characters supported: * (matches 0 or more characters) and ? (matches exactly 1 character). If the same header appears multiple times in the request they will be searched in order until a match is found. Only one pattern needs to match for the condition to be satisfied. To require that all of the strings are a match, create one condition block per string"
  type        = list(string)
  default     = ["/"]
}
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
variable "aws_lb_name" {
  description = "Name of the ALB"
  type        = string
  default     = ""
}
variable "aws_lb_listener_rule_priority" {

}
