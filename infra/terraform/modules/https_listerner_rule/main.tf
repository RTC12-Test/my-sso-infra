resource "aws_lb_listener_rule" "https_listener_rule" {
  listener_arn = var.aws_lb_listener_arn
  priority     = var.aws_lb_listener_rule_priority
  action {
    type = var.aws_lb_routing_rule_type
    forward {
      target_group {
        arn = var.aws_lb_https_listener_tg_arn
      }
    }
  }
  condition {
    path_pattern {
      values = var.aws_lb_https_path_values
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_lb_name}-${var.env}-lb-listener-rule"
    map-migrated = var.map_migrated_tag
  })
}
