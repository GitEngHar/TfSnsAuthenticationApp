resource "aws_security_group" "app-ecs" {
  name        = "app-ecs"
  description = "Allow alb to ecs traffic"
  vpc_id      = var.vpc_id
  tags = {
    Name = "app-ecs"
  }
}

resource "aws_security_group" "app-alb" {
  name        = "app-alb"
  description = "Allow alb traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "app-alb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-myip-ipv4" {
  security_group_id = aws_security_group.app-alb.id
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = var.app-from-port
  ip_protocol = "tcp"
  to_port     = var.app-to-port
}

resource "aws_vpc_security_group_ingress_rule" "allow-alb-ipv4" {
  security_group_id            = aws_security_group.app-ecs.id
  referenced_security_group_id = aws_security_group.app-alb.id
  from_port                    = var.app-from-port
  ip_protocol                  = "tcp"
  to_port                      = var.app-to-port
}


resource "aws_vpc_security_group_egress_rule" "allow-allip-alb" {
  security_group_id = aws_security_group.app-alb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow-allip-ecs" {
  security_group_id = aws_security_group.app-ecs.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}