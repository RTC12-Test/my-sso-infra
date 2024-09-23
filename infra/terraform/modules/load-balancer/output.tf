# Output for aws nlb
output "aws_nlb_arn" {
  value = aws_lb.nlb.arn
}
# Output for aws nlb-listener
output "aws_nlb_listener_arn" {
  value = aws_lb_listener.nlb_listener.arn
}
# Output for aws green target group name 
# Output for aws blue target group name
output "aws_lb_blue_target_name" {
  value = aws_lb_target_group.target_group.name
}
# Output for aws green target group arn
# Output for aws green target group arn
output "aws_lb_blue_target_arn" {
  value = aws_lb_target_group.target_group.arn
}
