variable "image_family_name" {
  description = "The family name of the ecs image"
  type        = string
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
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

variable "public-a_id" {
  description = "The ID to relate VPC for the sg"
  type = string
}

variable "app-to-port" {
  description = "The Port to relate App for the sg "
  type = number
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "sg_id_for_ecs" {
  description = "The sg for the ecs"
  type        = string
}

variable "container_image_name" {
  description = "The image name and version"
  type        = string
}