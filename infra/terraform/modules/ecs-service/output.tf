# Output for ecs service name 
output "ecs_name" {
  value = aws_ecs_service.ecs_service.name
}
