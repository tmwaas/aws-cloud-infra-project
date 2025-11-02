
resource "aws_lb" "app_alb" {
  name               = "app-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnets
  internal           = false
  enable_deletion_protection = false
  tags = {
    Name = "app-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "app-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path = "/"
    port = "3000"
    protocol = "HTTP"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}
