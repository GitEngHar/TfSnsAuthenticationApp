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
      name          = "mysql" # Service Connect の port_name に必要
    }]
  }])
}

resource "aws_service_discovery_private_dns_namespace" "app-db" {
  name        = var.host_name_for_db
  vpc         = var.vpc_id
  description = "Private DNS namespace for ECS service discovery"
}

resource "aws_service_discovery_service" "mysql" {
  name = "mysql"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.app-db.id
    dns_records {
      type = "A"
      ttl  = 10
    }
    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_ecs_service" "db_service" {
  name            = "db-service"
  cluster         = var.id-ecs-cluster
  task_definition = aws_ecs_task_definition.mysql.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [var.id-private]
    security_groups = [var.sg_id_for_connect_to_mysql]
    assign_public_ip = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.mysql.arn
  }

  service_connect_configuration {
    enabled = true
    namespace = "local"

    service {
      port_name = "mysql" # task 定義と一致
      client_alias {
        port     = 3306
        dns_name = "mysql"
      }
    }
  }
}
