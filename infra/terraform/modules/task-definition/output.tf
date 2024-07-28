# Output for task arn
output "task_arn" {
  value = aws_ecs_task_definition.task_definition.arn
}
# Output for task container port
output "aws_container_port" {
  value = jsondecode(aws_ecs_task_definition.task_definition.container_definitions)[0].PortMappings[0].ContainerPort
}
# Output for task container name
output "aws_container_name" {
  value = jsondecode(aws_ecs_task_definition.task_definition.container_definitions)[0].Name
}
# output "aws_ecr_repo" {
#   value = jsondecode(aws_ecs_task_definition.task_definition.container_definitions)[0].image
# }
