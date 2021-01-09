resource "aws_lb_target_group" "tg" {
  name     = var.tg_name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/login"
    port                = 8080
    healthy_threshold   = 6
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 5
    matcher             = "200"  # has to be HTTP 200 or fails
  }
}

resource "aws_lb_target_group_attachment" "tg" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.ec2_id
  port             = 8080
}

output "tg_arn" {
  value = aws_lb_target_group.tg.arn
}

output "tg_name" {
  value = aws_lb_target_group.tg.name
}
