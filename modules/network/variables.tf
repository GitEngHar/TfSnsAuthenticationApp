variable "vpc_cider_block" {
  description = "VPC cider block"
  type = string
  default = "10.0.0.0/16"
}

variable "public_a_cider_block" {
  type = string
  default = "10.0.1.0/24"
}

variable "public_c_cider_block" {
  type = string
  default = "10.0.2.0/24"
}

variable "private_a_cider_block" {
  type = string
  default = "10.0.128.0/24"
}