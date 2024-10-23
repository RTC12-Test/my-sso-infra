# Resource to create s3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  for_each = var.aws_s3_buckets
  bucket   = "${var.org_name}-${var.app_name}-${var.env}-${each.value.s3service_name}-bucket"
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.env}-${var.service_name}-bucket"
    map-migrated = var.map_migrated_tag
  })
}
resource "aws_s3_object" "s3_object" {
  for_each = false ? { for i in var.aws_s3_buckets : i.s3service_name => i } : {}
  bucket   = aws_s3_bucket.s3_bucket[each.value.s3service_name].id
  key      = "python.zip"
}
resource "aws_s3_bucket_versioning" "s3_versioning" {
  for_each = { for i in var.aws_s3_buckets : i.s3service_name => i }
  bucket   = aws_s3_bucket.s3_bucket[each.value.s3service_name].id
  versioning_configuration {
    status = ty
  }
}
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  for_each = var.create_aws_s3_bucket_policy ? { for i in var.aws_s3_buckets : i.s3service_name => i } : {}
  bucket   = aws_s3_bucket.s3_bucket[each.value.s3service_name].id
  policy   = templatefile(var.aws_s3_bucket_policy_file, merge(var.aws_s3_bucket_policy_vars, { "aws_s3_bucket_name" : aws_s3_bucket.s3_bucket.bucket }))
}
