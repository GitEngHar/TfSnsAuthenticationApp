variable "lambda_image_uri" {
  type = string
}

variable "subnet_id_a" {
  type = string
}


variable "subnet_id_c" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "lambda_environment" {
  type        = map(string)
}

variable "lambda_exec_role_arn" {
  type = string
}

variable "function-name" {
  type = string
}
