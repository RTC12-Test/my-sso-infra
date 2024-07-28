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
variable "aws_taskdefinition_volume_name" {
  description = "Name of the volume. This name is referenced in the sourceVolume parameter of container definition in the mountPoints section."
  type        = string
  default     = "mounting"
}
variable "aws_efs_id" {
  description = "ID of the EFS File System."
  type        = string
  default     = ""
}
variable "session_path" {
  description = "Directory within the Amazon EFS file system to mount as the root directory inside the host. If this parameter is omitted, the root of the Amazon EFS volume will be used. Specifying / will have the same effect as omitting this parameter."
  type        = string
  default     = "/"
}
variable "aws_taskdefinition_volume_encryption" {
  description = "Whether or not to enable encryption for Amazon EFS data in transit between the Amazon ECS host and the Amazon EFS server. Transit encryption must be enabled if Amazon EFS IAM authorization is used. Valid values: ENABLED, DISABLED. If this parameter is omitted, the default value of DISABLED is used."
  type        = string
  default     = "ENABLED"
}
