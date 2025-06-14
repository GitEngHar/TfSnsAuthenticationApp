resource "aws_lb" "test" {
  name                       = "test-lb-tf"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.sns-authentication-app-alb.id]
  subnets                    = [aws_subnet.public.id, aws_subnet.public-c.id]
  enable_deletion_protection = false # 削除しやすいように保護は無効化

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "ip-example" {
  name        = "tf-example-lb-tg"
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id
}

resource "aws_lb_listener" "test_listener" {
  load_balancer_arn = aws_lb.test.id
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip-example.arn
  }
}