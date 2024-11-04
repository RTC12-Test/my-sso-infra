# Calling locals of config module
locals {
  configs      = nonsensitive(module.config.config_env) # Retrieve configurations from the config module
  default_tags = module.config.default_tags
}

# Module for configuring common settings
module "config" {
  source                   = "./modules/config"
  enable_config_secrets    = true
  org_name                 = lookup(local.configs, "org_name")
  app_name                 = lookup(local.configs, "app_name")
  aws-migration-project-id = lookup(local.configs, "aws-migration-project-id")
  division                 = lookup(local.configs, "division")
  department               = lookup(local.configs, "department")
  technicalContact         = lookup(local.configs, "technicalContact")
  # sg_comman                = module.security_group.aws_sg_id["sg-comman"]
  # efs_id                   = module.efs.aws_efs_file_id
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

module "load-balancers" {
  for_each          = { for i in lookup(local.configs, "load-balancers") : i.aws_lb_name => i }
  source            = "./modules/load-balancers"
  app_name          = lookup(local.configs, "app_name")
  aws_lb_name       = each.value.aws_lb_name
  org_name          = lookup(local.configs, "org_name")
  env               = terraform.workspace
  default_tags      = local.default_tags
  aws_lb_sg_id      = [module.security_group.aws_sg_id[each.value.alb_sg]]
  aws_lb_vpc_subnet = lookup(local.configs, "aws_subnet")
  map_migrated_tag  = lookup(local.configs, "map_migrated_tag")
  aws_lb_type       = try(each.value.aws_lb_type, "application")
  aws_lb_protocol   = try(each.value.aws_lb_protocol, "HTTPS")
  # aws_lb_tg_arn     = module.default-target-groups[each.value.tg_name].tg_arn
  # enable_access_logs                = try(each.value.enable_alb_access_logs, false)
  # aws_lb_access_logs_s3_bucket_name = try(module.s3-buckets[each.value.s3_bucket_name].s3_bucket_name, "")
  create_http_listener = try(each.value.create_http_listener, false)
  # aws_acm_cerficate_arn             = try(each.value.certificate, lookup(local.configs, "aws_acm_cerficate_arn"))
  # depends_on                        = [module.s3-buckets]
}

#Module for Security Group for ALB
# module "security_group" {
#   source               = "./modules/security-group"
#   aws_sg_configuration = lookup(local.configs, "aws_sg_configuration")
#   app_name             = lookup(local.configs, "app_name")
#   org_name             = lookup(local.configs, "org_name")
#   env                  = terraform.workspace
#   service_name         = lookup(local.configs, "service_name")
#   default_tags         = local.default_tags
#   aws_vpc_id           = lookup(local.configs, "aws_vpc_id")
#   map_migrated_tag     = lookup(local.configs, "map_migrated_tag")
# }
module "ecr" {

  source           = "./modules/ecr"
  app_name         = lookup(local.configs, "app_name")
  org_name         = lookup(local.configs, "org_name")
  env              = terraform.workspace
  service_name     = lookup(local.configs, "service_name")
  default_tags     = local.default_tags
  map_migrated_tag = lookup(local.configs, "map_migrated_tag")
}

#
# # Module for aws_efs
# module "efs" {
#   source                      = "./modules/efs"
#   env                         = terraform.workspace
#   default_tags                = local.default_tags
#   org_name                    = lookup(local.configs, "org_name")
#   app_name                    = lookup(local.configs, "app_name")
#   aws_vpc_efs_subnets         = lookup(local.configs, "aws_subnet")
#   map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
#   efs_mount_security_group_id = module.security_group.aws_sg_id["efs"]
# }
#
# # Module for VPC Endpoint
# module "vpc_endpoint" {
#   org_name                      = lookup(local.configs, "org_name")
#   app_name                      = lookup(local.configs, "app_name")
#   source                        = "./modules/vpn-endpoint"
#   aws_vpc_endpoint_sg_ids       = [module.security_group.aws_sg_id["efs"], module.security_group.aws_sg_id["sg-comman"]]
#   aws_vpc_endpoint_subnet       = lookup(local.configs, "aws_subnet")
#   aws_vpc_endpoint_service_name = lookup(local.configs, "aws_vpc_endpoint_service_name")
#   aws_vpc_id                    = lookup(local.configs, "aws_vpc_id")
#   default_tags                  = local.default_tags
#   env                           = terraform.workspace
#   map_migrated_tag              = lookup(local.configs, "map_migrated_tag")
# }
