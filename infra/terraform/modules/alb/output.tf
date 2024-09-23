output "alb_name" {
  value = var.aws_alb_name
}
output "alb_target_arn" {
  value = { for i in var.aws_target_groups : i.tg_name => aws_lb_target_group.alb_target_group[i.tg_name].arn }
}
