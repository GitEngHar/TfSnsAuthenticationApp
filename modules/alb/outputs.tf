output "dns_name" {
  value = aws_lb.ecs-app-lb.dns_name
}

output "alb_ecs_service_listener_arn" {
  description = "The ARN of the listener"
  value = aws_lb_listener.ecs-app-lb-listener.arn
}

output "alb_ecs_service_target_group_id" {
  description = "The ARN of the target group"
  value = aws_lb_target_group.ecs-app-target-group.arn
}