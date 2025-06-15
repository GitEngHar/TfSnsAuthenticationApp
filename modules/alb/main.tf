resource "aws_lb" "ecs-app-lb" {
  name                       = "test-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.sg_id_for_alb]
  subnets                    = [var.public-a_id, var.public-c_id]
  enable_deletion_protection = false
  tags = {
    Environment = "hoge"
  }
}

resource "aws_lb_target_group" "ecs-app-target-group" {
  name        = "tf-example-lb-tg"
  port        = var.app-from-port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "ecs-app-lb-listener" {
  load_balancer_arn = aws_lb.ecs-app-lb.id
  port              = var.app-to-port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs-app-target-group.id
  }
}