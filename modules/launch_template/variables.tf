variable "ami_id" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "key_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list
}
