resource "aws_security_group" "app_ecs_sg" {
  name        = "app_ecs_sg"
  description = "Allow alb to ecs traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = "app_ecs_sg"
  }
}

resource "aws_security_group" "app_alb_sg" {
  name        = "app_alb_sg"
  description = "Allow alb traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = "app_alb_sg"
  }
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda_sg"
  description = "Allow lambda traffic to ecs app"
  vpc_id      = var.vpc_id
  tags = {
    Name = "lambda_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lambda_ingress_http_ipv4" {
  security_group_id = aws_security_group.app_alb_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 0
  ip_protocol = "tcp"
  to_port     = 65530
}

resource "aws_vpc_security_group_ingress_rule" "alb_ingress_http_ipv4" {
  security_group_id = aws_security_group.app_alb_sg.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = var.app_ingress_from_port
  ip_protocol = "tcp"
  to_port     = var.app_ingress_to_port
}

resource "aws_security_group" "mysql_sg" {
  name = "mysql-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.app_ecs_sg.id]
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_app_ingress_from_alb" {
  security_group_id            = aws_security_group.app_ecs_sg.id
  referenced_security_group_id = aws_security_group.app_alb_sg.id
  from_port                    = var.app_ingress_from_port
  ip_protocol                  = "tcp"
  to_port                      = var.app_ingress_to_port
}

resource "aws_vpc_security_group_ingress_rule" "ecs_app_ingress_from_lambda" {
  security_group_id            = aws_security_group.app_ecs_sg.id
  referenced_security_group_id = aws_security_group.lambda_sg.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 65530
}

resource "aws_vpc_security_group_egress_rule" "alb_egress_all_ipv4" {
  security_group_id = aws_security_group.app_alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "mysql_egress_all_ipv4" {
  security_group_id = aws_security_group.mysql_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "ecs_egress_all_ipv4" {
  security_group_id = aws_security_group.app_ecs_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "lambda_egress_all_ipv4" {
  security_group_id = aws_security_group.lambda_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}