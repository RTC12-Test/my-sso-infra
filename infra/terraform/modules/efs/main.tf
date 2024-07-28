# Resouce to create EFS file system
resource "aws_efs_file_system" "efs" {
  encrypted = var.efs_file_system_encrypted
  tags = {
    Name         = "${var.org_name}-${var.app_name}-${terraform.workspace}-efs"
    map-migrated = var.map_migrated_tag
  }
}


# Resource to create mount target for EFS
resource "aws_efs_mount_target" "efs_mount_target" {
  count           = length(var.aws_vpc_efs_subnets)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.aws_vpc_efs_subnets[count.index]
  security_groups = [var.efs_mount_security_group_id]
}

