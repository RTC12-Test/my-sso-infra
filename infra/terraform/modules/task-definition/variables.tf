variable "aws_ecs_task_definition_network_mode" {
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host"
  type        = string
  default     = "awsvpc"
}
variable "aws_ecs_task_definition_cpu" {
  description = "Number of cpu units used by the task. If the requires_compatibilities is FARGATE this field is required"
  type        = number
}
variable "aws_ecs_task_definition_memory" {
  description = "Amount (in MiB) of memory used by the task. If the requires_compatibilities is FARGATE this field is required"
  type        = number
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
variable "app_name" {
  description = "Application name"
  type        = string
  default     = ""
}
variable "aws_task_execution_role" {
  description = "ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume"
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
variable "task_definition_file" {
  description = "Task Definition file"
  type        = any
  # default     = "${path.module}/task-defnition-json.tpl"
}
variable "task_definition_variables" {
  description = "Task Definition variables"
  default     = null
}
variable "file_name" {
  default = "$filename"
}
variable "aws_region" {
  description = "aws region name"
  type        = string
  default     = ""
}
