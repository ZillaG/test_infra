resource "aws_subnet" "subnet" {
  availability_zone = var.availability_zone
  cidr_block        = var.cidr
  vpc_id            = var.vpc_id

  tags = {
    Name = var.name
  }
}

output "subnet_id" {
  value = aws_subnet.subnet.id
}
