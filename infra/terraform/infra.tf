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
  sg_comman                = module.security_group.aws_sg_id["sg-comman"]
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


# Module for Security Group for ALB
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

# Module for aws_efs
module "efs" {
  source                      = "./modules/efs"
  env                         = terraform.workspace
  default_tags                = local.default_tags
  org_name                    = lookup(local.configs, "org_name")
  app_name                    = lookup(local.configs, "app_name")
  aws_vpc_efs_subnets         = lookup(local.configs, "aws_subnets")
  map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
  efs_mount_security_group_id = module.security_group.aws_sg_id["efs"]
}

# Module for VPC Endpoint
module "vpc_endpoint" {
  source                        = "./modules/vpn-endpoint"
  aws_vpc_endpoint_sg_ids       = []
  aws_vpc_endpoint_subnet       = lookup(local.configs, "aws_subnets")
  aws_vpc_endpoint_service_name = lookup(local.configs, "aws_vpc_endpoint_service_name")
  aws_vpc_id                    = lookup(local.configs, "aws_vpc_id")
  default_tags                  = local.default_tags
}
