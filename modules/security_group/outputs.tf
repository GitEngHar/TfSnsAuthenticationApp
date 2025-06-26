output "ecs_service_access_security_group_id" {
  value = aws_security_group.app_ecs_sg.id
}

output "alb_access_security_group_id" {
  value = aws_security_group.app_alb_sg.id
}

output "mysql_access_security_group_id" {
  value = aws_security_group.mysql_sg.id
}

output "lambda_access_security_group_id" {
  value = aws_security_group.lambda_sg.id
}