
variable "vpc_id" {
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

