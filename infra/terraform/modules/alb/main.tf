# Resource to create ALB
resource "aws_lb" "alb" {
  name                             = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb"
  load_balancer_type               = var.aws_lb_type
  internal                         = var.aws_alb_internal
  subnets                          = var.aws_alb_vpc_subnet
  enable_deletion_protection       = var.aws_alb_enable_deletion_protection
  enable_cross_zone_load_balancing = var.aws_alb_load_balancing_cross_zone_enabled
  security_groups                  = var.aws_alb_sg_id
  idle_timeout                     = var.aws_alb_idle_timeout
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb"
    map-migrated = var.map_migrated_tag
  })
  # access_logs {
  #   bucket  = var.aws_alb_access_logs_s3_bucket_name
  #   prefix  = var.aws_alb_access_logs_prefix
  #   enabled = var.aws_alb_access_logs_enabled
  # }
}

locals {
  target_groups = { for tg in var.aws_target_groups : tg.tg_name => tg }
  targets       = [for tg in var.aws_target_groups : tg.tg_name]
}

# Resource to create ALB Target Group 
resource "aws_lb_target_group" "alb_target_group" {
  for_each    = local.target_groups
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

# Resource to create  ALB listener for HTTPS
resource "aws_lb_listener" "https" {
  count             = var.enable_codeploy ? 0 : 1
  load_balancer_arn = aws_lb.alb.arn
  port              = var.aws_alb_port
  protocol          = var.aws_alb_protocol
  certificate_arn   = var.aws_acm_cerficate_arn
  dynamic "default_action" {
    for_each = var.aws_target_groups
    content {
      type             = var.aws_alb_routing_type
      target_group_arn = aws_lb_target_group.alb_target_group[default_action.value.tg_name].arn
    }

  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb-https-listener"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [default_action]
  }
}

resource "aws_lb_listener" "https-code-deploy" {
  count             = var.enable_codeploy ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = var.aws_alb_port
  protocol          = var.aws_alb_protocol
  certificate_arn   = var.aws_acm_cerficate_arn
  default_action {
    type             = var.aws_alb_routing_type
    target_group_arn = aws_lb_target_group.alb_target_group[local.targets[0]].arn
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb-https-listener"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [default_action]
  }
}

# Resource to create ALB listener for HTTP
resource "aws_lb_listener" "http" {
  count             = var.enable_codeploy ? 0 : 1
  load_balancer_arn = aws_lb.alb.arn
  port              = var.aws_alb_http_port
  protocol          = var.aws_alb_http_protocol
  default_action {
    type = var.aws_alb_http_routing_type
    redirect {
      port        = var.aws_lb_listerner_redirect_port
      protocol    = var.aws_lb_listener_redirect_protocal
      status_code = var.aws_lb_listener_redirect_status_code
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb-http-listener"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [default_action]
  }
}

# Resource to create rules for HTTPS listener
resource "aws_lb_listener_rule" "https_listener_rule" {
  for_each     = { for tg in var.aws_target_groups : tg.tg_name => tg if tg.path_pattern != "" }
  listener_arn = aws_lb_listener.https[0].arn
  priority     = each.value.priority
  action {
    type = var.aws_alb_routing_type
    forward {
      target_group {
        arn = aws_lb_target_group.alb_target_group[each.key].arn
      }
      stickiness {
        duration = var.aws_lb_listener_rule_stickness_duration
        enabled  = var.aws_lb_listener_rule_stickness_enabled
      }
    }
  }
  condition {
    path_pattern {
      values = [each.value.path_pattern]
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${each.value.tg_name}-${var.env}-alb-listener-rule"
    map-migrated = var.map_migrated_tag
  })
}
