output "dns_name" {
  value = aws_lb.ecs_alb.dns_name
}

output "alb_ecs_service_target_group_id" {
  value = aws_lb_target_group.ecs_app_tg.arn
}

output "alb_ecs_service_listener_arn" {
  value = aws_lb_listener.ecs_app_alb_http_listener.arn
}

