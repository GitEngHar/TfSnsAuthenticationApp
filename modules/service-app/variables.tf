variable "task_definition_family" {
  type        = string
}

variable "ecs_service_log_group_name" {
  type = string
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "ecs_service_listener" {
  type = string
}


variable "lb_target_group_arn" {
  type = string
}

variable "ecs_cluster_id" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "container_name" {
  type = string
}

variable "public_a_subnet_id" {
  type = string
}

variable "container_port" {
  type = number
}

variable "aws_account_id" {
  type        = string
}

variable "app_access_security_group_id" {
  type        = string
}

variable "container_image" {
  type        = string
}