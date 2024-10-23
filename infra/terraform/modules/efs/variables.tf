variable "efs_mount_security_group_id" {
  description = "A list of up to 5 VPC security group IDs (that must be for the same VPC as subnet specified) in effect for the mount target"
  type        = string
  default     = ""

}
variable "org_name" {
  description = "Organisation name"
  type        = string
  default     = ""
}
variable "env" {
  description = "Environment"
  type        = string
  default     = ""
}
variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
  default     = {}
}
variable "map_migrated_tag" {
  description = "Workloads moving to AWS should have this tag"
  type        = string
  default     = ""
}
variable "app_name" {
  description = "Application name"
  type        = string
  default     = ""
}
variable "efs_file_system_encrypted" {
  description = "If true, the disk will be encrypted"
  type        = bool
  default     = true
}
variable "aws_vpc_efs_subnets" {
  description = "The IDS of the subnet to add the mount target in"
  type        = list(string)
  default     = [""]
}
variable "access_point_postfix_uid" {
  description = "POSIX user ID used for all file system operations using this access point"
  type        = number
  default     = 1000
}
variable "access_point_postfix_gid" {
  description = "POSIX group ID used for all file system operations using this access point"
  type        = number
  default     = 1000
}
variable "access_point_ci_uid_permission" {
  description = "POSIX permissions to apply to the RootDirectory, in the format of an octal number representing the file's mode bits"
  type        = string
  default     = "750"
}
variable "access_point_uid_path" {
  description = "Path on the EFS file system to expose as the root directory to NFS clients using the access point to access the EFS file system. A path can have up to four subdirectories. If the specified path does not exist, you are required to provide"
  type        = string
  default     = "/mnt/efs"
}
variable "access_point_ci_uid" {
  description = "POSIX user ID to apply to the root_directory"
  type        = number
  default     = 1000
}
variable "access_point_ci_gid" {
  description = "POSIX group ID to apply to the root_directory"
  type        = number
  default     = 1000
}
variable "archive_type" {
  description = "The type of archive to generate"
  type        = string
  default     = "zip"
}
