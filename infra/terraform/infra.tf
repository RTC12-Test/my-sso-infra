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

# # Calling Delinea module
# module "delinea" {
#   source             = "./modules/delinea"
#   env                = terraform.workspace
#   delinea_username   = lookup(local.secrets, "delinea_username")
#   delinea_password   = lookup(local.secrets, "delinea_password")
#   delinea_server_url = lookup(local.secrets, "delinea_server_url")
#   dlsecret           = lookup(local.configs, "dlsecret")
# }
# # Module for calling ecs-cluster module
module "ecs-cluster" {
  source           = "./modules/ecs-cluster"
  org_name         = lookup(local.configs, "org_name")
  app_name         = lookup(local.configs, "app_name")
  env              = terraform.workspace
  default_tags     = local.default_tags
  map_migrated_tag = lookup(local.configs, "map_migrated_tag")
}

module "security_group" {
  source               = "./modules/security-group"
  aws_sg_configuration = lookup(local.configs, "aws_sg_configuration")
  app_name             = lookup(local.configs, "app_name")
  org_name             = lookup(local.configs, "org_name")
  env                  = terraform.workspace
  service_name         = lookup(local.configs, "service_name")
  default_tags         = local.default_tags
  aws_vpc_id           = lookup(local.configs, "aws_vpc_id")
  map_migrated_tag     = lookup(local.configs, "map_migrated_tag")
}

module "alb" {
  for_each              = { for i, alb in lookup(local.configs, "albs") : i => alb }
  source                = "./modules/alb"
  app_name              = lookup(local.configs, "app_name")
  org_name              = lookup(local.configs, "org_name")
  env                   = terraform.workspace
  default_tags          = local.default_tags
  aws_vpc_id            = lookup(local.configs, "aws_vpc_id")
  aws_alb_vpc_subnet    = lookup(local.configs, "aws_subnet")
  aws_alb_port          = lookup(local.configs, "aws_alb_port")
  map_migrated_tag      = lookup(local.configs, "map_migrated_tag")
  aws_alb_internal      = lookup(local.configs, "aws_alb_internal")
  aws_alb_sg_id         = [module.security_group.aws_sg_id["app-alb"]]
  aws_acm_cerficate_arn = lookup(local.configs, "aws_acm_cerficate_arn")
  aws_alb_name          = each.value.aws_alb_name
  aws_target_groups     = each.value.aws_target_groups
  # aws_alb_access_logs_s3_bucket_name = module.s3.s3_bucket_name
  # aws_alb_access_logs_prefix         = each.value.aws_alb_access_logs_prefix
}
# module "secrets-manager" {
#   source           = "./modules/secrets-manager"
#   org_name         = lookup(local.configs, "org_name")
#   app_name         = lookup(local.configs, "app_name")
#   env              = terraform.workspace
#   default_tags     = local.default_tags
#   map_migrated_tag = lookup(local.configs, "map_migrated_tag")
#   aws_sercret_string = {
#     "acs1_ldap_pass"     = module.delinea.secret_values["acs1_ldap_password"].value
#     "emt_db_pwd"         = module.delinea.secret_values["emeta_database_cloud_password"].value
#     "bridge_account_id"  = module.delinea.secret_values["bridge_account_client-id"].value
#     "ssooauth_client_id" = module.delinea.secret_values["ssooauth_client-id"].value
#   }
# }

# Calling EFS module to create EFS
# module "efs" {
#   source                          = "./modules/efs"
#   env                             = terraform.workspace
#   default_tags                    = local.default_tags
#   org_name                        = lookup(local.configs, "org_name")
#   app_name                        = lookup(local.configs, "app_name")
#   aws_vpc_efs_subnets             = lookup(local.configs, "aws_subnet")
#   map_migrated_tag                = lookup(local.configs, "map_migrated_tag")
#   aws_efs_mount_security_group_id = ["sg-00ad135f2594702bc"]
#   aws_access_point_enable         = true
# }
#
# module "lambda" {
#   source              = "./modules/lambda_function"
#   env                 = terraform.workspace
#   default_tags        = local.default_tags
#   org_name            = lookup(local.configs, "org_name")
#   app_name            = lookup(local.configs, "app_name")
#   map_migrated_tag    = lookup(local.configs, "map_migrated_tag")
#   aws_lb_subnets      = lookup(local.configs, "aws_subnet")
#   aws_lambda_filename = lookup(local.configs, "aws_lambda_filename")
#   archive_source_dir  = lookup(local.configs, "archive_source_dir")
#   archive_output_path = lookup(local.configs, "archive_output_path")
#   aws_lambda_type     = lookup(local.configs, "aws_lambda_type")
# }

