resource "aws_lb" "main" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets             = ["${var.subnet_a}", "${var.subnet_b}"]
  security_groups     = ["${var.sg_id}"]

  tags = {
    name = "tf-alb"
  }
}

// target group

resource "aws_lb_target_group" "main" {
  name        = "tf-example-lb-alb-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

// listener

resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}


