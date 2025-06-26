resource "aws_lb" "ecs_alb" {
  name                       = "test-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_access_security_group_id]
  subnets                    = [var.public_a_subnet_id, var.public_c_subnet_id]
  enable_deletion_protection = false
  tags = {
    Environment = "hoge"
  }
}

resource "aws_lb_target_group" "ecs_app_tg" {
  name        = "tf-example-lb-tg"
  port        = var.app_ingress_from_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "ecs_app_alb_http_listener" {
  load_balancer_arn = aws_lb.ecs_alb.id
  port              = var.app_ingress_to_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_app_tg.id
  }
}