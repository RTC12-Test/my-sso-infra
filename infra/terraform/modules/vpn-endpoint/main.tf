resource "aws_vpc_endpoint" "efs_vpc_endpoint" {
  vpc_id             = var.aws_vpc_id
  service_name       = var.aws_vpc_endpoint_service_name
  vpc_endpoint_type  = var.aws_vpc_endpoint_type
  subnet_ids         = var.aws_vpc_endpoint_subnet
  security_group_ids = var.aws_vpc_endpoint_sg_ids
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.env}-vpc-endpoint"
    map-migrated = var.map_migrated_tag
  })
}
