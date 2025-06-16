
variable "vpc_id" {
  description = "The ID to relate VPC for the sg"
  type = string
}

variable "id-ecs-cluster" {
  description = "The Port to relate App for the sg "
  type = string
}

variable "id-private" {
  description = "The Port to relate App for the sg "
  type = number
}

variable "sg_id_for_connect_to_mysql" {
  description = "The Port to relate App for the sg "
  type = number
}

variable "container_environment" {
  type = list(object({
    name  = string
    value = string
  }))
}