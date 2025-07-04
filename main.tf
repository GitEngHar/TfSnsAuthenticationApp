terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

locals {
  container_environment = [
    {
      name  = "REDIRECT_URI"
      value = "http://${module.alb.dns_name}:8080/callback"
    },
    {
      name  = "CLIENT_ID"
      value = var.line_auth_client_id
    }
  ]
}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "network" {
  source                = "./modules/network"
  vpc_cider_block       = "10.0.0.0/16"
  public-a_cider_block  = "10.0.1.0/24"
  public-c_cider_block  = "10.0.2.0/24"
  private-a_cider_block = "10.0.128.0/24"
}

module "security_group" {
  source        = "./modules/security_group"
  vpc_id        = module.network.vpc_id
  app-to-port   = "8080"
  app-from-port = "8080"
}

module "alb" {
  source        = "./modules/alb"
  sg_id_for_alb = module.security_group.sg_id_for_alb
  vpc_id        = module.network.vpc_id
  app-to-port   = "8080"
  app-from-port = "8080"
  public-a_id   = module.network.public-a_id
  public-c_id   = module.network.public-c_id
}

module "cluster" {
  source          = "./modules/cluster"
  name_of_cluster = "SnsAuthAppCluster"
}

module "ecs" {
  source                = "./modules/service-app"
  task_def_family_name  = "SnsAuthenticationAppTaskDef"
  container_environment = local.container_environment
  arn_ecs_app_listener  = module.alb.arn_ecs_app_listener
  id_of_ecs_cluster     = module.cluster.cluster_id
  name_of_service       = "SnsAuthAppSvc"
  name_of_container     = "springapp"
  public-a_id           = module.network.public-a_id
  app-to-port           = "8080"
  aws_account_id        = var.aws_account_id
  sg_id_for_ecs         = module.security_group.sg_id_for_ecs
  container_image_name  = "sbs-authentication-app:latest"
  arn_lb_target_group   = ""
}


