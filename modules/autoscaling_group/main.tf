resource "aws_autoscaling_group" "asg" {
  availability_zones = var.availability_zones
  desired_capacity   = var.desired_capacity
  max_size           = var.max_size
  min_size           = var.min_size

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  timeouts {
    delete = "10m"
  }
}

resource "aws_autoscaling_policy" "asp" {
  name                   = "test_asp"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 10.0
  }
}

output "autoscaling_group_id" {
  value = aws_autoscaling_group.asg.id
}

output "autoscaling_policy_id" {
  value = aws_autoscaling_policy.asp.id
}
