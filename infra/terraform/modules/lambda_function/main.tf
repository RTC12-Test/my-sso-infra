# Data block to zip the code
data "archive_file" "zip_the_code" {
  count       = var.aws_lambda_type == "Zip" ? 1 : 0
  type        = lower(var.aws_lambda_type)
  source_dir  = "${path.root}/python"
  output_path = "${path.root}/python.zip"
}

# Resouce to create lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name    = "${var.org_name}-${var.app_name}-${var.service_name}-${var.env}-lambda"
  package_type     = var.aws_lambda_type
  image_uri        = var.aws_image_url
  filename         = var.aws_image_url != null ? null : "${path.root}/python_script.zip"
  handler          = var.aws_lf_handler
  runtime          = var.aws_lf_runtime
  role             = var.aws_iam_lambda_role
  source_code_hash = var.aws_lambda_type == "Image" ? null : data.archive_file.zip_the_code[0].output_base64sha256
  timeout          = var.aws_lf_timeout

  # VPC config for efs 
  dynamic "vpc_config" {
    for_each = try(var.aws_lb_vpc, {})
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.sg_id
    }
  }
  file_system_config {
    arn              = var.aws_efs_access_point_arn
    local_mount_path = var.aws_lambda_mount_point
  }
}

# Resource to create lambda invocation
resource "aws_lambda_invocation" "redeploy_lambda" {
  count         = var.aws_lambda_type == "Zip" ? 1 : 0
  function_name = aws_lambda_function.lambda_function.arn
  triggers = {
    redeployment = sha1(jsonencode([
      aws_lambda_function.lambda_function.source_code_hash
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