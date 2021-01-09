variable "cidr_blocks" {
  type = list
}

variable "name" {
  type = string
}

variable "ingress" {
  type = map
  default = {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
  }
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "your_home_public_ip" {
  type        = string
  description = "Your home's public IP to add to port 22 access"
}

