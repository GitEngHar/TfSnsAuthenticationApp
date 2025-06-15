terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "network" {
  source = "./modules/network"
  vpc_cider_block = "10.0.0.0/16"
  public-a_cider_block = "10.0.1.0/24"
  public-c_cider_block = "10.0.2.0/24"
  private-a_cider_block = "10.0.128.0/24"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.network.vpc_id
  app-to-port = "8080"
  app-from-port = "8080"
}

module "alb" {
  source = "./modules/alb"
  sg_id_for_alb = module.security_group.sg_id_for_alb
  vpc_id = module.network.vpc_id
  app-to-port = "8080"
  app-from-port = "8080"
  public-a_id = module.network.public-a_id
  public-c_id = module.network.public-c_id
}

module "ecs" {
  source = "./modules/ecs"
  image_family_name = ""
  container_environment = ""
  arn_ecs_app_listener = module.alb.arn_ecs_app_listener
  name_of_service = ""
  name_of_container = ""
  name_of_cluster = ""
  public-a_id = module.network.public-a_id
  app-to-port = "8080"
  aws_account_id = var.aws_account_id
  sg_id_for_ecs = module.security_group.sg_id_for_ecs
}


