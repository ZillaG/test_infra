variable "alb_name" {
  type = string
}

variable "alb_security_group_ids" {
  type = list
}

variable "eng_ziftsolutions_cert_arn" {
  type    = string
  default = "arn:aws:acm:us-east-1:803597461034:certificate/fecef2dd-d460-43d2-a2fc-53f7eae8a202"
}

variable "subnets" {
  type = list
}

variable "tg_arn" {
  type = string
}

variable "vpc_security_group_ids" {
  type = list
  default = ["sg-640c8f1b"]
}

