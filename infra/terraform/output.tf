# Output for cluster name 
output "aws_ecs_cluster_name" {
  value = module.ecs-cluster.aws_ecs_cluster_name
}
output "efs_id" {
  value = module.config.efs_id
}
