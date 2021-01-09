resource "aws_security_group" "security_group" {
  name                   = var.name
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true
  description            = "Allow Port 80 inbound traffic"

  ingress {
    description = "Port 80 traffic"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Port 22 traffic"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
//    cidr_blocks = ["136.56.173.122/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
//    cidr_blocks = ["136.56.173.122/32"]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.name
  }
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}
