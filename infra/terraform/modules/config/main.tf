# Fetching the properties of sops file 
data "sops_file" "secrets" {
  count       = local.sops_file_exists ? 1 : 0
  source_file = local.sops_source_file
}

# Calls config path
locals {
  config_path      = var.config_path != "" ? var.config_path : "${path.root}/config_env"
  environment      = var.environment != "" ? var.environment : terraform.workspace
  sops_source_file = "${local.config_path}/${local.environment}/secrets.enc.yaml"
  sops_file_exists = fileexists(local.sops_source_file)
  secrets          = local.sops_file_exists ? data.sops_file.secrets[0].data : {}
  default_tags = merge(var.default_tags, {
    "environment"      = local.environment
    "org"              = var.org_name
    "application"      = var.app_name
    "division"         = var.division
    "technicalContact" = var.technicalContact
    "tier"             = local.environment
    "department"       = var.department
  })

  # Define template variables to use in template file
  tpl_vars = {
    secrets     = var.enable_config_secrets ? local.secrets : {}
    environment = local.environment
    terraform = {
      workspace = terraform.workspace
    }
  }

  # Decode each file, but only if it's not empty and is a valid YAML document
  files_env   = toset([for f in fileset("${local.config_path}/${local.environment}", "*.yaml") : f if substr(f, -9, -1) != ".enc.yaml"])
  configs_env = toset([for f in local.files_env : try(yamldecode(templatefile("${local.config_path}/${local.environment}/${f}", local.tpl_vars)))])
  configs     = merge(local.configs_env...)
}
