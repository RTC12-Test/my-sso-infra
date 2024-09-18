# Data block to zip the code
data "archive_file" "zip_the_code" {
  count       = var.aws_lambda_type == "Zip" ? 1 : 0
  type        = lower(var.aws_lambda_type)
  source_dir  = var.archive_source_dir
  output_path = var.archive_output_path
}

# Resouce to create lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-lambda"
  package_type  = var.aws_lambda_type
  image_uri     = try(var.aws_image_url, null)
  s3_bucket     = var.aws_lambda_type == "Image" ? null : var.aws_lambda_s3_name
  s3_key        = var.aws_lambda_type == "Image" ? null : var.aws_lambda_s3_key
  handler       = var.aws_lambda_type == "Image" ? null : var.aws_lf_handler
  runtime       = var.aws_lambda_type == "Image" ? null : var.aws_lf_runtime
  role          = var.aws_iam_lambda_role
  # source_code_hash = var.aws_lambda_type == "Image" ? null : var.aws_lambda_s3_key_hash
  timeout = var.aws_lf_timeout
  # VPC config for efs 
  dynamic "vpc_config" {
    for_each = var.aws_lb_vpc_enable ? [1] : []
    content {
      subnet_ids         = var.aws_lb_subnets
      security_group_ids = var.aws_lb_sg_ids
    }
  }
  dynamic "file_system_config" {
    for_each = var.aws_lb_fs_enable ? [1] : []
    content {
      arn              = var.aws_efs_access_point_arn
      local_mount_path = var.aws_lambda_mount_point
    }
  }
  tags = {
    Name         = "${var.org_name}-${var.app_name}-${terraform.workspace}-lambda"
    map-migrated = var.map_migrated_tag
  }
}

# Resource to create lambda invocation
resource "aws_lambda_invocation" "redeploy_lambda" {
  count         = var.aws_lambda_type == "Zip" ? 1 : 0
  function_name = aws_lambda_function.lambda_function.arn
  triggers = {
    redeployment = sha1(jsonencode([
      var.aws_lambda_type == "Zip" ? var.aws_lambda_s3_key : null
    ]))
  }
  input = jsonencode({
    key1 = "value1"
  })
}

# Lambda Permission for S3
resource "aws_lambda_permission" "s3_invoke" {
  count         = var.aws_s3_trigger ? 1 : 0
  statement_id  = var.aws_lp_statement_id
  action        = var.aws_lp_action
  function_name = aws_lambda_function.lambda_function.arn
  principal     = var.aws_lb_principal
  source_arn    = var.aws_s3_bucket_source_arn
}

# S3 Bucket Notification for Lambda Trigger
resource "aws_s3_bucket_notification" "s3_trigger" {
  count  = var.aws_s3_trigger ? 1 : 0
  bucket = var.aws_s3_bucket_id
  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda_function.arn
    events              = var.aws_s3_no_events
    filter_suffix       = var.aws_s3_no_fs
  }
}
