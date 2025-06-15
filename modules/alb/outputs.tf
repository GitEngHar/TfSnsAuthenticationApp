output "dns_name" {
  description = "The ID of the vpn"
  value = aws_lb.ecs-app-lb.dns_name
}

output "arn_ecs_app_listener" {
  description = "The ARN of the listener"
  value = aws_lb_listener.ecs-app-lb-listener.arn
}

output "arn_lb_target_group" {
  description = "The ARN of the target group"
  value = aws_lb_target_group.ecs-app-target-group.arn
}