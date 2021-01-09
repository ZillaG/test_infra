resource "aws_launch_template" "lt" {
  name                   = "test_launch_template"
  description            = "Launch template for ASG"
  image_id               = var.ami_id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  update_default_version = true
  user_data              = filebase64("${path.module}/run_app.sh")

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.vpc_security_group_ids
    subnet_id                   = var.subnet_id
  }

  placement {
    availability_zone = var.availability_zone
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test_launch_template"
    }
  }

}

output "launch_template_id" {
  value = aws_launch_template.lt.id
}
