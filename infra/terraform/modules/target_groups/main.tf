resource "aws_lb_target_group" "alb_target_group" {
  for_each    = var.aws_target_groups
  name        = "${var.org_name}-${var.app_name}-${each.value.tg_name}-${var.env}-tg"
  port        = var.aws_lb_target_group_port
  vpc_id      = var.aws_vpc_id
  protocol    = var.aws_lb_target_group_protocal
  target_type = var.aws_lb_target_group_type
  health_check {
    path                = each.value.health_path
    port                = var.aws_lb_target_group_health_port
    protocol            = var.aws_lb_target_group_health_protocol
    healthy_threshold   = var.aws_lb_target_group_healthy_threshold
    unhealthy_threshold = var.aws_lb_target_group_unhealthy_threshold
  }
  dynamic "stickiness" {
    for_each = var.enable_stickness ? [1] : []
    content {
      enabled = var.aws_lb_tg_stickness_enabled
      type    = var.aws_lb_tg_stickeness_type
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${each.value.tg_name}-${var.env}-tg"
    map-migrated = var.map_migrated_tag
  })
}
