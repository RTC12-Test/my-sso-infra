# Resource to create task definition
resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-task-definition"
  network_mode             = var.aws_ecs_task_definition_network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.aws_ecs_task_definition_cpu
  memory                   = var.aws_ecs_task_definition_memory
  execution_role_arn       = var.aws_task_execution_role
  task_role_arn            = var.aws_task_execution_role
  container_definitions    = templatefile(var.task_definition_file, var.task_definition_variables)
  volume {
    name = var.aws_taskdefinition_volume_name
    efs_volume_configuration {
      file_system_id     = var.aws_efs_id
      root_directory     = var.session_path
      transit_encryption = var.aws_taskdefinition_volume_encryption
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-task-definition"
    map-migrated = var.map_migrated_tag
  })
}
