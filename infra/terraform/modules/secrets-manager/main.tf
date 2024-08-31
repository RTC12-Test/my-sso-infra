resource "aws_secretsmanager_secret" "secrets-manager" {
  name = "${var.org_name}-${var.app_name}-${var.env}-secret-manager"
  tags = merge(var.default_tags, {
    Name         = "${var.org_name}-${var.app_name}-${var.env}-secret-manager"
    map-migrated = var.map_migrated_tag
  })
}
resource "aws_secretsmanager_secret_version" "secerts_string" {
  secret_id     = aws_secretsmanager_secret.secrets-manager.id
  secret_string = jsonencode(var.aws_sercret_string)
}
