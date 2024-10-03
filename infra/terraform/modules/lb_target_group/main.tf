resource "aws_lb_target_group" "target_group" {
  name        = "${var.org_name}-${var.app_name}${var.service_name}-${var.aws_lb_tg_service_name}-${var.env}-tg"
  port        = var.aws_lb_tg_port
  vpc_id      = var.aws_vpc_id
  protocol    = var.aws_lb_tg_protocal
  target_type = var.aws_lb_tg_type
  health_check {
    path                = var.aws_lb_tg_health_path
    port                = var.aws_lb_tg_health_port
    protocol            = var.aws_lb_tg_health_protocol
    healthy_threshold   = var.aws_lb_tg_healthy_threshold
    unhealthy_threshold = var.aws_lb_tg_unhealthy_threshold
  }
  dynamic "stickiness" {
    for_each = var.enable_stickness ? [1] : []
    content {
      cookie_duration = var.aws_lb_tg_cookie_duration
      enabled         = var.aws_lb_tg_stickness_enabled
      type            = var.aws_lb_tg_stickeness_type

    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}${var.service_name}-${var.aws_lb_tg_service_name}-${var.env}-tg"
    map-migrated = var.map_migrated_tag
  })
}
