# Output for s3 bucket
output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}

# Output of s3 bucket id
output "aws_s3_bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}
# Output of s3 bucket arn
output "aws_s3_bucket_arn" {
  description = "The s3 bucket arn"
  value       = aws_s3_bucket.s3_bucket.arn
}
# Output of s3 bucket arn
output "aws_s3_object_version_id" {
  value = aws_s3_object.s3_object[length(count.index - 1)].version_id
}
