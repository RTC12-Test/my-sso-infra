output "tg_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "alb_name" {
  value = aws_lb_target_group.target_group.name
}
