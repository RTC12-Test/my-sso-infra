# Resource to create task definition
resource "aws_ecs_task_definition" "task_definition" {
  family                   = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-task-definition"
  network_mode             = var.aws_ecs_task_definition_network_mode
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.aws_ecs_task_definition_cpu
  memory                   = var.aws_ecs_task_definition_memory
  execution_role_arn       = var.aws_task_execution_role
  task_role_arn            = var.aws_task_execution_role
  container_definitions    = templatefile(var.task_definition_file, local.task_definition_vars)
  dynamic "volume" {
    for_each = try(var.task_definition_variables.volumes.bind, {})
    content {
      name = volume.value.name
    }
  }
  dynamic "volume" {
    for_each = try(var.task_definition_variables.volumes.efs, {})
    content {
      name = volume.value.name
      efs_volume_configuration {
        file_system_id     = volume.value.efs_id
        root_directory     = try(volume.value.efs_access_point, []) != [] ? var.session_path : try(volume.value.session_path, var.session_path)
        transit_encryption = var.aws_taskdefinition_volume_encryption
        dynamic "authorization_config" {
          for_each = try([for i in volume.value.efs_access_point : i], [])
          content {
            access_point_id = authorization_config.value
          }
        }
      }
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-task-definition"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [volume]
  }
}
