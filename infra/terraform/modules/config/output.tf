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
  value = "${path.module}/task-definition-json.tpl"
}
output "s3policyfile" {
  value = "${path.module}/policy.json"
}
output "s3policy_nlbfile" {
  value = "${path.module}/policy-nlb.json"
}
