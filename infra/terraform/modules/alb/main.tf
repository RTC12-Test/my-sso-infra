# Resource to create LB
resource "aws_lb" "lb" {
  name                             = "${var.org_name}-${var.app_name}-${var.aws_lb_name}-${var.env}-lb"
  load_balancer_type               = var.aws_lb_type
  internal                         = var.aws_lb_internal
  subnets                          = var.aws_lb_vpc_subnet
  enable_deletion_protection       = var.aws_lb_enable_deletion_protection
  enable_cross_zone_load_balancing = var.aws_lb_load_balancing_cross_zone_enabled
  security_groups                  = var.aws_lb_sg_id
  idle_timeout                     = var.aws_lb_idle_timeout
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_lb_name}-${var.env}-lb"
    map-migrated = var.map_migrated_tag
  })
  access_logs {
    bucket  = var.aws_lb_access_logs_s3_bucket_name
    prefix  = var.aws_lb_access_logs_prefix
    enabled = var.aws_lb_access_logs_enabled
  }
}

# Resource to create  LB listener for HTTPS
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.aws_lb_port
  protocol          = var.aws_lb_protocol
  certificate_arn   = var.aws_acm_cerficate_arn
  default_action {
    type             = var.aws_lb_routing_type
    target_group_arn = var.aws_lb_tg_arn
  }

  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_lb_name}-${var.env}-lb-https-listener"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [default_action]
  }
}

# Resource to create LB listener for HTTP
resource "aws_lb_listener" "http" {
  count             = var.enable_codeploy ? 0 : 1
  load_balancer_arn = aws_lb.lb.arn
  port              = var.aws_lb_http_port
  protocol          = var.aws_lb_http_protocol
  default_action {
    type = var.aws_lb_http_routing_type
    redirect {
      port        = var.aws_lb_listerner_redirect_port
      protocol    = var.aws_lb_listener_redirect_protocal
      status_code = var.aws_lb_listener_redirect_status_code
    }
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.aws_lb_name}-${var.env}-lb-http-listener"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [default_action]
  }
}
