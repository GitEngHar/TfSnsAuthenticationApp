variable "vpc_cider_block" {
  description = "VPC cider block"
  type = string
  default = "10.0.0.0/16"
}

variable "public-a_cider_block" {
  description = "Public subnet cider block of public-a"
  type = string
  default = "10.0.1.0/24"
}

variable "public-c_cider_block" {
  description = "Public subnet cider block of public-c"
  type = string
  default = "10.0.2.0/24"
}

variable "private-a_cider_block" {
  description = "Private subnet cider block of private-a"
  type = string
  default = "10.0.128.0/24"
}