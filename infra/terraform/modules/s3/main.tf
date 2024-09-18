# Resource to create s3 bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.org_name}-${var.app_name}-${var.env}-${var.service_name}-bucket"
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.env}-${var.service_name}-bucket"
    map-migrated = var.map_migrated_tag
  })
}
# Resource to create s3 bucket
resource "aws_s3_object" "s3_bucket" {
  bucket = "${var.org_name}-${var.app_name}-${var.env}-${var.service_name}-bucket-key"
  key    = ""
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.env}-${var.service_name}-bucket-key"
    map-migrated = var.map_migrated_tag
  })
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  count  = var.create_aws_s3_bucket_policy ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  policy = var.aws_s3_bucket_policy
}




