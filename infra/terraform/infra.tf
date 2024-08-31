# Calling locals of config module
locals {
  configs      = nonsensitive(module.config.config_env) # Retrieve configurations from the config module
  default_tags = module.config.default_tags
  secrets      = module.config.secrets
}

# Module for configuring common settings
module "config" {
  source                = "./modules/config"
  enable_config_secrets = true
  org_name              = lookup(local.configs, "org_name")
  app_name              = lookup(local.configs, "app_name")
  division              = lookup(local.configs, "division")
  department            = lookup(local.configs, "department")
  technicalContact      = lookup(local.configs, "technicalContact")
}

module "delinea" {
  source             = "./modules/delinea"
  env                = terraform.workspace
  delinea_username   = lookup(local.secrets, "delinea_username")
  delinea_password   = lookup(local.secrets, "delinea_password")
  delinea_server_url = lookup(local.secrets, "delinea_server_url")
  dlsecret           = lookup(local.configs, "dlsecret")
}
# Module for calling ecs-cluster module
module "ecs-cluster" {
  source           = "./modules/ecs-cluster"
  org_name         = lookup(local.configs, "org_name")
  app_name         = lookup(local.configs, "app_name")
  env              = terraform.workspace
  default_tags     = local.default_tags
  map_migrated_tag = lookup(local.configs, "map_migrated_tag")
}
module "secrets-manager" {
  source           = "./modules/secrets-manager"
  org_name         = lookup(local.configs, "org_name")
  app_name         = lookup(local.configs, "app_name")
  env              = terraform.workspace
  default_tags     = local.default_tags
  map_migrated_tag = lookup(local.configs, "map_migrated_tag")
  aws_sercret_string = {
    "acs1_ldap_pass"     = module.delinea.secret_values["acs1_ldap_password"].value
    "emt_db_pwd"         = module.delinea.secret_values["emeta_database_cloud_password"].value
    "bridge_account_id"  = module.delinea.secret_values["bridge_account_client-id"].value
    "ssooauth_client_id" = module.delinea.secret_values["ssooauth_client-id"].value
  }
}
