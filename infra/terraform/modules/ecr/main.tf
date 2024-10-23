# Resource to create ECR Repository
resource "aws_ecr_repository" "ecr" {
  name                 = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-ecr"
  image_tag_mutability = var.aws_repository_image_tag_mutability
  encryption_configuration {
    encryption_type = var.aws_repository_encryption_type
    kms_key         = var.aws_repository_kms_key
  }
  force_delete = var.aws_repository_force_delete
  image_scanning_configuration {
    scan_on_push = var.aws_scanning_configuration
  }
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-ecr"
    map-migrated = var.map_migrated_tag
  })
}

# Resource to create ECR Scanning
resource "aws_ecr_registry_scanning_configuration" "configuration" {
  count     = var.enable_ecr_scanning ? 1 : 0
  scan_type = var.aws_ecr_scan_type
  rule {
    scan_frequency = var.aws_ecr_scan_frequency
    repository_filter {
      filter      = aws_ecr_repository.ecr.name
      filter_type = var.aws_ecr_scan_filter_type
    }
  }
}
