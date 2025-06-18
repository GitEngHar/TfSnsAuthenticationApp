
variable "ecs_cluster_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}


variable "mysql_access_security_group_id" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "task_definition_family" {
  type        = string
}

variable "aws_account_id" {
  type = string
}

variable "service_discovery_id" {
  type = string
}