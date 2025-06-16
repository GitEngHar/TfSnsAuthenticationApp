output "sg_id_for_ecs" {
  description = "The ID of the sg for the ecs"
  value = aws_security_group.app-ecs.id
}

output "sg_id_for_alb" {
  description = "The ID of the sg for the alb"
  value = aws_security_group.app-alb.id
}

output "sg_id_for_connect_to_mysql" {
  description = "The ID of the sg for the db"
  value = aws_security_group.mysql_sg.id
}