# Calling locals of config module
# locals {
#   configs      = nonsensitive(module.config.config_env) # Retrieve configurations from the config module
#   default_tags = module.config.default_tags
#   secrets      = module.config.secrets
# }
#
# # Module for configuring common settings
# module "config" {
#   source                = "./modules/config"
#   enable_config_secrets = true
#   org_name              = lookup(local.configs, "org_name")
#   app_name              = lookup(local.configs, "app_name")
#   division              = lookup(local.configs, "division")
#   department            = lookup(local.configs, "department")
#   technicalContact      = lookup(local.configs, "technicalContact")
# }

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
# module "ecs-cluster" {
#   source           = "./modules/ecs-cluster"
#   org_name         = lookup(local.configs, "org_name")
#   app_name         = lookup(local.configs, "app_name")
#   env              = terraform.workspace
#   default_tags     = local.default_tags
#   map_migrated_tag = lookup(local.configs, "map_migrated_tag")
# }
#
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

# module "s3-sso-front-alb" {
#   source                      = "./modules/s3"
#   org_name                    = lookup(local.configs, "org_name")
#   app_name                    = lookup(local.configs, "app_name")
#   env                         = terraform.workspace
#   service_name                = "s3-sso-${terraform.workspace}-front-alb"
#   default_tags                = local.default_tags
#   map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
#   create_aws_s3_bucket_policy = lookup(local.configs, "create_aws_s3_bucket_policy")
#   aws_s3_bucket_policy_file   = "../../policy.json"
#   aws_s3_bucket_policy_vars = {
#     "aws_elb_account_id" : lookup(local.configs, "aws_elb_account_id")
#   }
# }
# module "s3-sso-back-alb" {
#   source                      = "./modules/s3"
#   org_name                    = lookup(local.configs, "org_name")
#   app_name                    = lookup(local.configs, "app_name")
#   env                         = terraform.workspace
#   service_name                = "sso--back-alb"
#   default_tags                = local.default_tags
#   map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
#   create_aws_s3_bucket_policy = lookup(local.configs, "create_aws_s3_bucket_policy")
#   aws_s3_bucket_policy_file   = module.config.s3policyfile
#   aws_s3_bucket_policy_vars = {
#     "aws_elb_account_id" : lookup(local.configs, "aws_elb_account_id")
#     "aws_s3_bucket_name" : "${lookup(local.configs, "org_name")}-${lookup(local.configs, "app_name")}-${terraform.workspace}-s3-sso-${terraform.workspace}-back-alb-bucket"
#   }
# }

# module "s3-client-front-alb" {
#   source                      = "./modules/s3"
#   org_name                    = lookup(local.configs, "org_name")
#   app_name                    = lookup(local.configs, "app_name")
#   env                         = terraform.workspace
#   service_name                = "s3-client-${terraform.workspace}-front-alb"
#   default_tags                = local.default_tags
#   map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
#   create_aws_s3_bucket_policy = lookup(local.configs, "create_aws_s3_bucket_policy")
#   aws_s3_bucket_policy_file   = module.config.s3policyfile
#   aws_s3_bucket_policy_vars = {
#     "aws_elb_account_id" : lookup(local.configs, "aws_elb_account_id")
#     "aws_s3_bucket_name" : "${lookup(local.configs, "org_name")}-${lookup(local.configs, "app_name")}-${terraform.workspace}-s3-client-${terraform.workspace}-front-alb-bucket"
#   }
# }
# module "s3-client-alb-back" {
#   source                      = "./modules/s3"
#   org_name                    = lookup(local.configs, "org_name")
#   app_name                    = lookup(local.configs, "app_name")
#   env                         = terraform.workspace
#   service_name                = "s3-client-${terraform.workspace}-back-alb"
#   default_tags                = local.default_tags
#   map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
#   create_aws_s3_bucket_policy = lookup(local.configs, "create_aws_s3_bucket_policy")
#   aws_s3_bucket_policy_file   = module.config.s3policyfile
#   aws_s3_bucket_policy_vars = {
#     "aws_elb_account_id" : lookup(local.configs, "aws_elb_account_id")
#     "aws_s3_bucket_name" : "${lookup(local.configs, "org_name")}-${lookup(local.configs, "app_name")}-${terraform.workspace}-s3-client-${terraform.workspace}-back-alb-bucket"
#   }
# }
# module "s3-sso-nlb" {
#   source                      = "./modules/s3"
#   org_name                    = lookup(local.configs, "org_name")
#   app_name                    = lookup(local.configs, "app_name")
#   env                         = terraform.workspace
#   service_name                = "sso-nlb-log-s3" acs-sso-dev-s-bucket
#   default_tags                = local.default_tags
#   map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
#   create_aws_s3_bucket_policy = lookup(local.configs, "create_aws_s3_bucket_policy")
#   aws_s3_bucket_policy_file   = module.config.s3policy_nlbfile
#   aws_s3_bucket_policy_vars = {
#     "aws_s3_bucket_name" : "${lookup(local.configs, "org_name")}-${lookup(local.configs, "app_name")}-${terraform.workspace}-s3-sso-${terraform.workspace}-nlb-bucket"
#   }
# }

# module "sso-front-alb" {
#   source                            = "./modules/alb"
#   app_name                          = lookup(local.configs, "app_name")
#   org_name                          = lookup(local.configs, "org_name")
#   env                               = terraform.workspace
#   default_tags                      = local.default_tags
#   aws_lb_name                       = "sso-front-alb"
#   aws_lb_sg_id                      = [module.security_group.aws_sg_id["sso-alb-front"]]
#   aws_lb_vpc_subnet                 = lookup(local.configs, "aws_subnet")
#   aws_lb_port                       = lookup(local.configs, "aws_alb_port")
#   map_migrated_tag                  = lookup(local.configs, "map_migrated_tag")
#   aws_lb_internal                   = false
#   aws_acm_cerficate_arn             = lookup(local.configs, "aws_acm_cerficate_arn")
#   aws_lb_type                       = "application"
#   aws_lb_access_logs_s3_bucket_name = module.s3-sso-front-alb.s3_bucket_name
#   aws_lb_protocol                   = "HTTPS"
#   aws_lb_http_port                  = "80"
#   aws_lb_tg_arn                     = module.tg-front-alb.tg_arn
# }

# module "sso-nlb" {
#   source                            = "./modules/alb"
#   app_name                          = lookup(local.configs, "app_name")
#   org_name                          = lookup(local.configs, "org_name")
#   env                               = terraform.workspace
#   aws_lb_name                       = "sso-back-alb"
#   default_tags                      = local.default_tags
#   aws_lb_sg_id                      = [module.security_group.aws_sg_id["sso-alb-back"]]
#   aws_lb_vpc_subnet                 = lookup(local.configs, "aws_subnet")
#   aws_lb_port                       = lookup(local.configs, "aws_alb_port")
#   map_migrated_tag                  = lookup(local.configs, "map_migrated_tag")
#   aws_lb_internal                   = true
#   aws_acm_cerficate_arn             = lookup(local.configs, "aws_acm_cerficate_arn")
#   aws_lb_type                       = "application"
#   aws_lb_protocol                   = "HTTPS"
#   enable_codeploy                   = true
#   aws_lb_access_logs_s3_bucket_name = module.s3-sso-back-alb.s3_bucket_name
#   aws_lb_tg_arn                     = module.tg-back-alb.tg_arn
# }

# data "aws_ecr_repository" "hello" {
#   name = lookup(local.configs, "aws_ecr_repository_name")
# }

# module "sso-nlb" {
#   source                            = "./modules/alb"
#   app_name                          = lookup(local.configs, "app_name")
#   aws_lb_name                       = "sso-nlb"
#   org_name                          = lookup(local.configs, "org_name")
#   env                               = terraform.workspace
#   default_tags                      = local.default_tags
#   aws_lb_sg_id                      = [module.security_group.aws_sg_id["sso-nlb"]]
#   aws_lb_vpc_subnet                 = lookup(local.configs, "aws_subnet")
#   aws_lb_port                       = lookup(local.configs, "aws_alb_port")
#   map_migrated_tag                  = lookup(local.configs, "map_migrated_tag")
#   aws_lb_internal                   = true
#   aws_lb_type                       = "network"
#   enable_codeploy                   = true
#   aws_lb_access_logs_s3_bucket_name = module.s3-sso-nlb.s3_bucket_name
#   aws_lb_protocol                   = "TCP"
#   aws_lb_tg_arn                     = module.tg-nlb.tg_arn
#
# }
# module "tg-front-alb" {
#   source                 = "./modules/lb_target_group"
#   org_name               = lookup(local.configs, "org_name")
#   app_name               = lookup(local.configs, "app_name")
#   env                    = terraform.workspace
#   default_tags           = local.default_tags
#   aws_vpc_id             = lookup(local.configs, "aws_vpc_id")
#   aws_lb_tg_protocal     = "HTTPS"
#   aws_lb_tg_port         = 443
#   aws_lb_tg_health_path  = "/test"
#   aws_lb_tg_service_name = "tg-front-alb"
# }
# module "tg-nlb" {
#   source                 = "./modules/lb_target_group"
#   org_name               = lookup(local.configs, "org_name")
#   app_name               = lookup(local.configs, "app_name")
#   env                    = terraform.workspace
#   default_tags           = local.default_tags
#   aws_vpc_id             = lookup(local.configs, "aws_vpc_id")
#   aws_lb_tg_protocal     = "TCP"
#   aws_lb_tg_port         = 443
#   aws_lb_tg_health_path  = "/test"
#   aws_lb_tg_service_name = "tg-nlb"
#   aws_lb_tg_type         = "alb"
# }
# module "tg-back-alb" {
#   source                 = "./modules/lb_target_group"
#   org_name               = lookup(local.configs, "org_name")
#   app_name               = lookup(local.configs, "app_name")
#   env                    = terraform.workspace
#   default_tags           = local.default_tags
#   aws_vpc_id             = lookup(local.configs, "aws_vpc_id")
#   aws_lb_tg_protocal     = "HTTPS"
#   aws_lb_tg_port         = 8443
#   aws_lb_tg_health_path  = "/"
#   aws_lb_tg_service_name = "tg-back-alb"
# }
# aws_lb_tg_arn = 
# module "s3-client-nlb" {
#   source                      = "./modules/s3"
#   org_name                    = lookup(local.configs, "org_name")
#   app_name                    = lookup(local.configs, "app_name")
#   env                         = terraform.workspace
#   service_name                = "s3-sso-${terraform.workspace}-nlb"
#   default_tags                = local.default_tags
#   map_migrated_tag            = lookup(local.configs, "map_migrated_tag")
#   create_aws_s3_bucket_policy = lookup(local.configs, "create_aws_s3_bucket_policy")
#   aws_s3_bucket_policy_file   = module.config.s3policyfile
#   aws_s3_bucket_policy_vars = {
#     "aws_elb_account_id" : lookup(local.configs, "aws_elb_account_id")
#     "aws_s3_bucket_name" : "${lookup(local.configs, "org_name")}-${lookup(local.configs, "app_name")}-${terraform.workspace}-s3-sso-${terraform.workspace}-nlb-bucket"
#   }
# }
# module "alb" {
#   for_each     = { for i, alb in lookup(local.configs, "albs") : i => alb }
#   source       = "./modules/alb"
#   app_name     = lookup(local.configs, "app_name")
#   org_name     = lookup(local.configs, "org_name")
#   env          = terraform.workspace
#   default_tags = local.default_tags
#   # aws_vpc_id            = lookup(local.configs, "aws_vpc_id")
# }
