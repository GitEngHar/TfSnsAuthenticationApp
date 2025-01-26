resource "aws_security_group" "sns-authentication-app-ecs" {
  name        = "sns-authentication-app-ecs"
  description = "Allow alb to ecs traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "sns-authentication-app-ecs"
  }
}

resource "aws_security_group" "sns-authentication-app-alb" {
  name        = "sns-authentication-app-alb"
  description = "Allow alb traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "sns-authentication-app-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-myip-ipv4" {
  security_group_id = aws_security_group.sns-authentication-app-alb.id
  # cidr_ipv4         = var.my_global_ip
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  ip_protocol = "tcp"
  to_port     = 8080
}

resource "aws_vpc_security_group_ingress_rule" "allow-alb-ipv4" {
  security_group_id            = aws_security_group.sns-authentication-app-ecs.id
  referenced_security_group_id = aws_security_group.sns-authentication-app-alb.id
  from_port                    = 8080
  ip_protocol                  = "tcp"
  to_port                      = 8080
}


resource "aws_vpc_security_group_egress_rule" "allow-allip-alb" {
  security_group_id = aws_security_group.sns-authentication-app-alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow-allip-ecs" {
  security_group_id = aws_security_group.sns-authentication-app-ecs.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}