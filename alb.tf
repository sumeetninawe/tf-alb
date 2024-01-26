// ALB
resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.vpc_sg]
  subnets            = [var.subnet_a, var.subnet_b, var.subnet_c]

  tags = {
    Environment = "dev"
  }
}

// Listener
resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_a.arn
  }
}

// Listener Rule
# resource "aws_lb_listener_rule" "rule_a" {
#   listener_arn = aws_lb_listener.my_alb_listener.arn
#   priority     = 20

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.my_tg_a.arn
#   }

#   condition {
#     path_pattern {
#       values = ["/*"]
#     }
#   }
# }

resource "aws_lb_listener_rule" "rule_b" {
  listener_arn = aws_lb_listener.my_alb_listener.arn
  priority     = 60

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_b.arn
  }

  condition {
    path_pattern {
      values = ["/images*"]
    }
  }
}

resource "aws_lb_listener_rule" "rule_c" {
  listener_arn = aws_lb_listener.my_alb_listener.arn
  priority     = 40

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_c.arn
  }

  condition {
    path_pattern {
      values = ["/register*"]
    }
  }
}

resource "aws_lb_listener_rule" "rule_lambda" {
  listener_arn = aws_lb_listener.my_alb_listener.arn
  priority     = 80

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg_lambda.arn
  }

  condition {
    path_pattern {
      values = ["/greeting*"]
    }
  }
}

// Target groups
resource "aws_lb_target_group" "my_tg_a" { // Target Group A
  name     = "target-group-a"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "my_tg_b" { // Target Group B
  name     = "target-group-b"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "my_tg_c" { // Target Group C
  name     = "target-group-c"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Define the target group for Lambda
resource "aws_lb_target_group" "my_tg_lambda" { // Target Group Lambda
  name        = "target-group-lambda"
  target_type = "lambda"
  vpc_id      = var.vpc_id
}

// Target group attachment
resource "aws_lb_target_group_attachment" "tg_attachment_a" {
  target_group_arn = aws_lb_target_group.my_tg_a.arn
  target_id        = aws_instance.instance_a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_b" {
  target_group_arn = aws_lb_target_group.my_tg_b.arn
  target_id        = aws_instance.instance_b.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_c" {
  target_group_arn = aws_lb_target_group.my_tg_c.arn
  target_id        = aws_instance.instance_c.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attachment_lambda" {
  target_group_arn = aws_lb_target_group.my_tg_lambda.arn
  target_id        = aws_lambda_function.my_lambda.arn
}