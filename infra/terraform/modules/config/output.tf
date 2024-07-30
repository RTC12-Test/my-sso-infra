# Output for config
output "config_env" {
  value = local.configs
}
# Output for default tags
output "default_tags" {
  value = local.default_tags
}
# Output for aws vpc id
output "secrets" {
  value = local.secrets
}
output "taskdefintionfile" {
  value     = "${path.module}/task-definition-json.tpl"
  sensitive = true
}
