output "ecs_service_access_security_group_id" {
  value = aws_security_group.app-ecs.id
}

output "alb_access_security_group_id" {
  value = aws_security_group.app-alb.id
}

output "mysql_access_security_group_id" {
  value = aws_security_group.mysql_sg.id
}