# Resource to create ALB
# resource "aws_lb" "alb" {
#   name                             = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb"
#   load_balancer_type               = var.aws_lb_type
#   internal                         = var.aws_alb_internal
#   subnets                          = var.aws_alb_vpc_subnet
#   enable_deletion_protection       = var.aws_alb_enable_deletion_protection
#   enable_cross_zone_load_balancing = var.aws_alb_load_balancing_cross_zone_enabled
#   security_groups                  = var.aws_alb_sg_id
#   idle_timeout                     = var.aws_alb_idle_timeout
#   tags = merge(var.default_tags, {
#     Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb"
#     map-migrated = var.map_migrated_tag
#   })
#   # access_logs {
#   #   bucket  = var.aws_alb_access_logs_s3_bucket_name
#   #   prefix  = var.aws_alb_access_logs_prefix
#   #   enabled = var.aws_alb_access_logs_enabled
#   # }
# }


# Resource to create ALB Target Group 

# Resource to create  ALB listener for HTTPS
# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = var.aws_alb_port
#   protocol          = var.aws_alb_protocol
#   certificate_arn   = var.aws_acm_cerficate_arn
#   dynamic "default_action" {
#     for_each = var.enable_codeploy ? [] : var.aws_target_groups
#     content {
#       type             = var.aws_alb_routing_type
#       target_group_arn = aws_lb_target_group.alb_target_group[default_action.value.tg_name].arn
#     }
#
#   }
#   tags = merge(var.default_tags, {
#     Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb-https-listener"
#     map-migrated = var.map_migrated_tag
#   })
#   lifecycle {
#     ignore_changes = [default_action]
#   }
# }
#

# Resource to create ALB listener for HTTP
# resource "aws_lb_listener" "http" {
#   count             = var.enable_codeploy ? 0 : 1
#   load_balancer_arn = aws_lb.alb.arn
#   port              = var.aws_alb_http_port
#   protocol          = var.aws_alb_http_protocol
#   default_action {
#     type = var.aws_alb_http_routing_type
#     redirect {
#       port        = var.aws_lb_listerner_redirect_port
#       protocol    = var.aws_lb_listener_redirect_protocal
#       status_code = var.aws_lb_listener_redirect_status_code
#     }
#   }
#   tags = merge(var.default_tags, {
#     Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${var.env}-alb-http-listener"
#     map-migrated = var.map_migrated_tag
#   })
#   lifecycle {
#     ignore_changes = [default_action]
#   }
# }

# Resource to create rules for HTTPS listener
resource "aws_lb_listener_rule" "https_listener_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = var.aws_lb_https_listener_rule_priority
  action {
    type = var.aws_alb_routing_type
    forward {
      target_group {
        arn = var.aws_lb_https_listener_tg_arn
      }
    }
  }
  condition {
    path_pattern {
      values = var.aws_lb_https_listener_rule_path_value
    }
    host_header {
      values = var.aws_lb_https_listener_rule_host_header_value
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_alb_name}-${each.value.tg_name}-${var.env}-alb-listener-rule"
    map-migrated = var.map_migrated_tag
  })
}
