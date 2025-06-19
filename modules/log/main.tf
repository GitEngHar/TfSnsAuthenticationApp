resource "aws_cloudwatch_log_group" "ecs_app_log_group" {
  name              = "/ecs/my-ecs-task"
  retention_in_days = var.log_save_duration
}
