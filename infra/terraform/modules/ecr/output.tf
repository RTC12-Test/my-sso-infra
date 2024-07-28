# Output for ECR repo
output "aws_ecr_repo_name" {
  value = aws_ecr_repository.ecr.name
}
