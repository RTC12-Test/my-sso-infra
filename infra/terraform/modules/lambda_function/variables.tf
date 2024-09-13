variable "aws_iam_lambda_role" {
  description = "Amazon Resource Name (ARN) of the function's execution role. The role provides the function's identity and access to AWS services and resources"
  type        = string
  default     = ""
}
variable "aws_lf_sg_ids" {
  description = "List of security group IDs associated with the Lambda function"
  type        = list(string)
  default     = [""]
}
variable "org_name" {
  description = "Organisation name"
  type        = string
  default     = "rtctek"
}
variable "app_name" {
  description = "Application name"
  type        = string
  default     = "app_name"
}
variable "service_name" {
  description = "Service name"
  type        = string
  default     = "service_name"
}
variable "env" {
  description = "Environment name"
  type        = string
  default     = "env"
}
variable "aws_lf_runtime" {
  description = "Identifier of the function's runtime. See Runtimes for vali"
  type        = string
  default     = "python3.8"
}
variable "aws_lf_handler" {
  description = "Function entrypoint in your code."
  type        = string
  default     = "index.handler"
}
variable "aws_lambda_filename" {
  description = "filename for lambda function"
  type        = string
  default     = null
}
variable "subnet" {
  description = "subnet for lambda function"
  type        = string
  default     = ""
}
variable "aws_lambda_type" {
  description = "lambda type"
  type        = string
  default     = "Zip"
}
variable "archive_source_dir" {
  description = "Package entire contents of this directory into the archive. One and only one of source, source_content_filename (with source_content), source_file, or source_dir must be specified"
  type        = string
  default     = ""
}
variable "archive_output_path" {
  description = "The output of the archive file."
  type        = string
  default     = ""
}
variable "aws_lf_timeout" {
  description = "Amount of time your Lambda Function has to run in seconds. Defaults to 3. See Limits"
  type        = string
  default     = "10"
}
variable "package_type" {
  description = "package type of lambda function"
  type        = string
  default     = "Zip"
}
variable "aws_image_url" {
  description = "Container image url"
  type        = string
  default     = null
}
variable "aws_lb_vpc" {
  description = "Contains maps of security and subnets-id"
  type        = string
  default     = "False"
}
variable "aws_lb_vpc_configuration" {
  description = "vpc configuration flag"
  type        = any
  default     = null
}
variable "efs_configuration" {
  description = "efs configuration flag"
  type        = string
  default     = "False"
}
variable "aws_efs_access_point_arn" {
  description = "efs access point arn"
  type        = string
  default     = ""
}
variable "aws_lambda_mount_point" {
  description = "efs mounting point directory"
  type        = string
  default     = ""
}
variable "aws_s3_trigger" {
  description = "s3 flag trigger"
  type        = bool
  default     = false
}
variable "aws_s3_bucket_id" {
  description = "Name of the bucket for notification configuration."
  type        = string
  default     = ""
}
variable "aws_s3_bucket_source_arn" {
  description = "en the principal is an AWS service, the ARN of the specific resource within that service to grant permission to. Without this, any resource from principal will be granted permission – even if that resource is from another account. For S3, this should be the ARN of the S3 Bucket. For EventBridge events, this should be the ARN of the EventBridge Rule. For API Gateway, this should be the ARN of the API, as described here"
  type        = string
  default     = ""
}
variable "aws_lp_statement_id" {
  description = "A unique statement identifier. By default generated by Terraform"
  type        = string
  default     = "AllowS3InvokeLambda"
}
variable "aws_lp_action" {
  description = "The AWS Lambda action you want to allow in this statement"
  type        = string
  default     = "lambda:InvokeFunction"
}
variable "aws_lb_principal" {
  description = "The principal who is getting this permission e.g., s3.amazonaws.com, an AWS account ID, or AWS IAM principal, or AWS service principal such as events.amazonaws.com or sns.amazonaws.com"
  type        = string
  default     = "s3.amazonaws.com"
}
variable "aws_s3_no_fs" {
  description = "Object key name suffix"
  type        = string
  default     = ".crt"
}
variable "aws_s3_no_events" {
  description = "Event for which to send notifications."
  type        = list(string)
  default     = ["s3:ObjectCreated:*"]
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
