variable "availability_zones" {
  type        = list
  description = "The AZ to use"
}

variable "desired_capacity" {
  type        = number
  default     = 1
  description = "Desired EC2 capacity"
}

variable "max_size" {
  type        = number
  default     = 2
  description = "Maximum EC2s in the ASG"
}

variable "min_size" {
  type        = number
  default     = 2
  description = "Mininum EC2s in the ASG"
}

variable "launch_template_id" {
  type        = string
  description = "The launch template to use"
}
