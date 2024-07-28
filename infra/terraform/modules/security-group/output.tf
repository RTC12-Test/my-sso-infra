# Output for security group id 
output "aws_sg_id" {
  value = { for i in var.aws_sg_configuration : i.name => aws_security_group.security_group[i.name].id }
}
