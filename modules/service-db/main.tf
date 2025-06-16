# -------------------------
# ECS タスク定義 (MySQL)
# -------------------------
resource "aws_ecs_task_definition" "mysql" {
  family                   = var.task_def_family_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"

  container_definitions = jsonencode([{
    name      = "mysql"
    image     = var.name_of_container_image
    essential = true
    environment = var.container_environment
    portMappings = [{
      containerPort = 3306,
      name          = "mysql"  # Service Connect用に必須
    }]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = "/ecs/mysql"
        awslogs-region        = "ap-northeast-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

# -------------------------
# ECS サービス (MySQL)
# -------------------------
resource "aws_ecs_service" "db_service" {
  name            = "db-service"
  cluster         = var.id-ecs-cluster
  task_definition = aws_ecs_task_definition.mysql.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = [var.id-private]
    security_groups  = [var.sg_id_for_connect_to_mysql]
    assign_public_ip = false  # Service Connectではfalseが推奨
  }

  service_connect_configuration {
    enabled   = true
    namespace = var.dns_service_connect

    service {
      port_name = "mysql"  # タスク定義の portMappings.name と一致させる
      client_alias {
        port     = 3306
        dns_name = "mysql"
      }
    }
  }

}
