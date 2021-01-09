variable "availability_zone" {
  type        = string
  default     = "us-east-1b"
  description = "The AWS availability zone"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS region"
}

variable "profile" {
  type        = string
  default     = "cfoutsaws"
  description = "The AWS profile to use"
}

variable "public_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDikEs3tqPQNTiNDRsI10R0uFKxp9L8JIrQc+n3lxNHRht84Zo3nsKRq0K2WHBVQj/ZXNvHQtGPp45M8sB99/Hov0LD9flb86M/MtWnBc3BQiX7v1iJwyN5zbmxCjnE2CsGZeZXvWjUMkQTMvlXqtMbiFWaJ7Hgl2duHq0Papdl4LRoc33ArR4lXSiyqPaE96MobItPqpQ13vLbyMwrfL2wASbfZevLLyJ9d+ipcO6GtLnuRO4FoK3jOVJY1ChG9IoITsg/0+8KmVdoLYcFSWQOuN1NjH1P8AJhlak4t6Eyd9ihiDGg3kSuHoPt6O8RsEc1beQKUevDrSX/stdVsHPPE6aLIwnH3vr/dAGO0VIOiLqltfwCiGbs9Jahzcrm+r4yEKjja2ObKL9ZnZx2nAvJNM9S6ahu2KvWYcU7yZTG9+Wax2ou60Q6Tb2Q1Y/1RsMbmAG4esh4/VheCvRQpXslV4JRdPzKBZ/PBWZu+BWeicNbAAOvaEJ94mvCciwpA/s= cfouts@ip-192-168-205-150.ec2.internal"
  description = "The AWS profile to use"
}

variable "aws_creds_file" {
  type        = string
  default     = "/Users/cfouts/.aws/credentials"
  description = "AWS credentials"
}

variable "cidr" {
  type        = string
  default     = "10.205.156.0/24"
  description = "CIDR"
}
