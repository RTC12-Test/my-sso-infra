# Output of file system id
output "aws_efs_file_id" {
  value = aws_efs_file_system.efs.id
}
# Output of efs access point arn
output "aws_access_point_arn" {
  value = aws_efs_access_point.access_point.arn
}

