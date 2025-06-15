output "sg_id_for_ecs" {
  description = "The ID of the sg for the ecs"
  value = aws_security_group.app-ecs.id
}

output "sg_id_for_alb" {
  description = "The ID of the sg for the alb"
  value = aws_security_group.app-alb.id
}