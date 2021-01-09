resource "aws_vpc" "vpc" {
  cidr_block = var.cidr

  tags = {
    Name = var.name
  }
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}
