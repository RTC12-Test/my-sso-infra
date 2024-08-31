# Secrets value
output "secret_values" {
  value     = { for k, secret in data.tss_secret.secret_field : k => secret }
  sensitive = true
}