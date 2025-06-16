output "log_name" {
  description = "saved log stream name"
  value = aws_cloudwatch_log_group.ecs_log_group.name
}