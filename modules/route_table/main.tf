resource "aws_route_table" "gw" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = var.name
  }
}

resource "aws_main_route_table_association" "default" {
  vpc_id         = var.vpc_id
  route_table_id = aws_route_table.gw.id
}

