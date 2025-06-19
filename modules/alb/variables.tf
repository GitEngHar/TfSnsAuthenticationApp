variable "alb_access_security_group_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "app_ingress_to_port" {
  type = number
}

variable "app_ingress_from_port" {
  description = "The Port to relate App for the sg "
  type = number
}

variable "public_a_subnet_id" {
  type = string
}

variable "public_c_subnet_id" {
  type = string
}

