terraform {
  required_providers {
    aws = {
      //TODO: 設定の意味を調べよう
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}

// TODO: 環境変数かGithubSecretにする
provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
