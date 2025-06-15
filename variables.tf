## provider
variable "aws_access_key" {
  description = "IAM ACCESS KEY"
  type        = string
}

variable "aws_secret_key" {
  description = "IAM SECRET KEY"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "my_global_ip" {
  description = "MY ACCESS IP"
  type        = string
}

variable "line_auth_client_id" {
  type = string
}

variable "vpc_id" {
  description = "The ID to relate VPC for the sg"
  type = string
}

variable "public-a_id" {
  description = "The ID to relate VPC for the sg"
  type = string
}

variable "public-c_id" {
  description = "The ID to relate VPC for the sg"
  type = string
}

variable "private-a_id" {
  description = "The ID to relate VPC for the sg"
  type = string
}

variable "app-to-port" {
  description = "The Port to relate App for the sg "
  type = number
}

variable "app-from-port" {
  description = "The Port to relate App for the sg "
  type = number
}

variable "sg_id_for_app_ecs" {
  description = "The ID of the sg for the ecs"
  type = string
}

variable "sg_id_for_app_alb" {
  description = "The ID of the sg for the alb"
  type = string
}

variable "vpc_ingress_sg_id_for_allow_my_ip_ipv4" {
  description = "The ID of the sg for the allow my ip"
  type = string
}

variable "vpc_ingress_sg_id_for_allow_alb_ipv4" {
  description = "The ID of the sg for the allow my ip"
  type = string
}

variable "vpc_egress_sg_id_for_allow_all_alb_ip" {
  description = "The ID of the sg for the allow alb ip"
  type = string
}

variable "vpc_egress_sg_id_for_allow_all_ecs_ip" {
  description = "The ID of the sg for the allow ecs ip"
  type = string
}