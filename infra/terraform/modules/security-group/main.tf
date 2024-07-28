# Resource to create Security Group 
resource "aws_security_group" "security_group" {
  for_each    = { for i in var.aws_sg_configuration : i.name => i }
  name        = "${var.org_name}-${var.app_name}-${var.service_name}-${each.value.name}-${var.env}-sg"
  vpc_id      = var.aws_vpc_id
  description = "${var.app_name}-${var.service_name}-${each.value.name}-service"
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-sg"
    Used_by      = var.service_name
    map-migrated = var.map_migrated_tag
  })
}

# Combine Ingress and Egress rules
locals {
  combined_ingress_rules = flatten([
    for ingress in var.aws_sg_configuration : [
      for cidrs in ingress.aws_sg_ingress_rules : [
        for aws_sg_cidr in cidrs.aws_sg_ingress_cidr_ip4 : [
          for port in cidrs.aws_sg_inbound_port : [
            for aws_reference_sg in cidrs.aws_reference_sg : [
              for aws_reference_sg_id in cidrs.aws_reference_sg_id : {
                aws_sg_cidr         = aws_sg_cidr
                port                = port
                condition           = cidrs.aws_sg_enable_alb_cidr_ipv4
                name                = ingress.name
                aws_reference_sg    = aws_reference_sg
                aws_reference_sg_id = aws_reference_sg_id
              }
            ]
          ]
        ]
      ]
    ]
  ])
  combined_egress_rules = flatten([
    for egress in var.aws_sg_configuration : [
      for cidrs in egress.aws_sg_egress_rules : [
        for aws_sg_cidr in cidrs.aws_sg_ingress_cidr_ip4 : [
          for port in cidrs.aws_sg_inbound_port : [
            for aws_reference_sg in cidrs.aws_reference_sg : [
              for aws_reference_sg_id in cidrs.aws_reference_sg_id : {
                aws_sg_cidr         = aws_sg_cidr
                port                = port
                condition           = cidrs.aws_sg_enable_alb_cidr_ipv4
                name                = egress.name
                aws_reference_sg    = aws_reference_sg
                aws_reference_sg_id = aws_reference_sg_id
              }
            ]
          ]
        ]
      ]
    ]
  ])
}

# Resource to create Security Group Ingress rules IPV4 
resource "aws_vpc_security_group_ingress_rule" "ingress_rule_allow_cidr4_ip4" {
  for_each                     = { for sg_info in local.combined_ingress_rules : "${sg_info.name}-${sg_info.aws_sg_cidr}${sg_info.aws_reference_sg}${sg_info.aws_reference_sg_id}-${sg_info.port}" => sg_info }
  from_port                    = each.value.port
  to_port                      = each.value.port
  security_group_id            = aws_security_group.security_group[each.value.name].id
  ip_protocol                  = var.aws_sg_ingress_protocal
  cidr_ipv4                    = each.value.condition ? each.value.aws_sg_cidr : null
  referenced_security_group_id = each.value.condition ? null : each.value.aws_reference_sg != "" ? aws_security_group.security_group[each.value.aws_reference_sg].id : each.value.aws_reference_sg_id
}

# Resource to Create Security Group Egress rules IPV4
resource "aws_vpc_security_group_egress_rule" "egress_rule_ip4" {
  for_each                     = { for sg_info in local.combined_egress_rules : "${sg_info.name}-${sg_info.aws_sg_cidr}${sg_info.aws_reference_sg}${sg_info.aws_reference_sg_id}-${sg_info.port}" => sg_info }
  security_group_id            = aws_security_group.security_group[each.value.name].id
  cidr_ipv4                    = each.value.condition ? each.value.aws_sg_cidr : null
  from_port                    = each.value.port
  to_port                      = each.value.port
  ip_protocol                  = var.aws_sg_egress_protocal
  referenced_security_group_id = each.value.condition ? null : each.value.aws_reference_sg != "" ? aws_security_group.security_group[each.value.aws_reference_sg].id : each.value.aws_reference_sg_id
}
