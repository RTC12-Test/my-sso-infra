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
  security_groups = var.aws_efs_mount_security_group_id
}

# Resource to create access point target for EFS
resource "aws_efs_access_point" "test" {
  count          = var.aws_access_point_enable ? 1 : 0
  file_system_id = aws_efs_file_system.efs.id
  root_directory {
    path = var.aws_access_point_path
    creation_info {
      owner_gid   = var.aws_efs_ac_ci_gid
      owner_uid   = var.aws_efs_ac_ci_uid
      permissions = var.aws_efs_ac_permissions
    }
  }
  posix_user {
    gid = var.aws_efs_ac_posfix_gid
    uid = var.aws_efs_ac_postfix_uid
  }
  tags = {
    Name         = "${var.org_name}-${var.app_name}-${terraform.workspace}-access-point"
    map-migrated = var.map_migrated_tag
  }
}
