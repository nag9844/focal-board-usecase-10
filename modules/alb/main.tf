# ALB for focalboard
resource "aws_lb" "focalboard" {
  name               = "focalboard-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "focalboard-alb"
  }
}

# Target Group for focalboard (port 8080 on instance)
resource "aws_lb_target_group" "focalboard" {
  name     = "focalboard-tg"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

# Target attachment for focalboard instance
resource "aws_lb_target_group_attachment" "focalboard" {
  target_group_arn = aws_lb_target_group.focalboard.arn
  target_id        = var.focalboard_instance
  port             = 8000
}


# Listener for focalboard ALB
resource "aws_lb_listener" "focalboard_http" {
  load_balancer_arn = aws_lb.focalboard.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.focalboard.arn
  }
}

