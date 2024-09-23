# Resource to create NLB
resource "aws_lb" "nlb" {
  name                             = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-nlb"
  load_balancer_type               = var.aws_lb_type
  subnets                          = var.aws_nlb_vpc_subnet
  security_groups                  = var.aws_nlb_sg_id
  internal                         = var.aws_nlb_internal
  enable_deletion_protection       = var.aws_enable_deletion_protection
  enable_cross_zone_load_balancing = var.aws_enable_cross_zone_load_balancing
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-nlb"
    map-migrated = var.map_migrated_tag
  })
}

# Resource to create a listener for the NLB on HTTPS
resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.aws_nlb_port
  protocol          = var.aws_nlb_protocol
  certificate_arn   = var.aws_acm_cerficate_arn
  default_action {
    type             = var.aws_nlb_routing_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-nlb-listener"
    map-migrated = var.map_migrated_tag
  })
  lifecycle {
    ignore_changes = [default_action]
  }
}

# Resource to add target group 
resource "aws_lb_target_group" "target_group" {
  vpc_id                            = var.aws_vpc_id
  name                              = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-tg"
  port                              = var.aws_lb_target_group_port
  protocol                          = var.aws_lb_target_group_protocal
  target_type                       = var.aws_lb_target_group_type
  load_balancing_cross_zone_enabled = var.aws_load_balancing_cross_zone_enabled
  health_check {
    path     = var.aws_lb_target_group_health_path
    port     = var.aws_lb_target_group_health_port
    protocol = var.aws_lb_target_group_health_protocol
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-tg"
    map-migrated = var.map_migrated_tag
  })
}
