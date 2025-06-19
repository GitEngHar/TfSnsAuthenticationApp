# -------------------------
# ECS タスク定義 (MySQL)
# -------------------------
resource "aws_ecs_task_definition" "mysql" {
  family                   = var.task_definition_family
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([{
    name      = "mysql"
    image     = var.container_image
    essential = true
    environment = var.container_environment
    portMappings = [{
      containerPort = 3306
    }]
  }])
}

resource "aws_service_discovery_service" "mysql" {
  name = "mysql"

  dns_config {
    namespace_id = var.service_discovery_id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

# -------------------------
# ECS サービス (MySQL)
# -------------------------
resource "aws_ecs_service" "db_service" {
  name            = "db-service"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.mysql.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [var.private_subnet_id]
    security_groups  = [var.mysql_access_security_group_id]
    assign_public_ip = true  # Service Connectではfalseが推奨
  }

  service_registries {
    registry_arn = aws_service_discovery_service.mysql.arn
  }
}
