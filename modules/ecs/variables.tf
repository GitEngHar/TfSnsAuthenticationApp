variable "image_family_name" {
  description = "The family name of the ecs image"
  type        = string
}

variable "container_environment" {
  description = "The dns name of the environment"
  type = string
}

variable "arn_ecs_app_listener" {
  description = "The arn of the ecs listener"
  type = string
}

variable "name_of_service" {
  description = "The name of the service"
  type = string
}

variable "name_of_container" {
  description = "The name of the container"
  type = string
}

variable "name_of_cluster" {
  description = "The name of the cluster"
  type = string
}
