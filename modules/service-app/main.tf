resource "aws_ecs_task_definition" "app_task_def" {
  family                   = var.task_definition_family
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  container_definitions    = jsonencode([
    {
      name  = var.container_name
      image = "${var.aws_account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${var.container_image}"
      portMappings = [
        {
          containerPort = var.container_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_service_log_group_name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "my-app"
        }
      }
      environment = var.container_environment
    }
  ])
}

resource "aws_service_discovery_service" "app_service_discovery" {
  name = "app"

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

# https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html
resource "aws_lb_listener_rule" "app_service_listener_rule" {
  # ルールを追加するリスナー
  listener_arn = var.ecs_service_listener

  # 受け取ったトラフィックをターゲットグループへ受け渡す
  action {
    type             = "forward"
    target_group_arn = var.lb_target_group_arn
  }

  # ターゲットグループへ受け渡すトラフィックの条件
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}


# https://www.terraform.io/docs/providers/aws/r/ecs_service.html
resource "aws_ecs_service" "app_service" {
  name = var.ecs_service_name

  # 依存関係の記述。
  # "aws_lb_listener_rule.main" リソースの作成が完了するのを待ってから当該リソースの作成を開始する。
  # "depends_on" は "aws_ecs_service" リソース専用のプロパティではなく、Terraformのシンタックスのため他の"resource"でも使用可能
  depends_on = [aws_lb_listener_rule.app_service_listener_rule]

  # 当該ECSサービスを配置するECSクラスターの指定
  cluster = var.ecs_cluster_id

  # データプレーンとしてFargateを使用する
  launch_type = "FARGATE"

  # ECSタスクの起動数を定義
  desired_count = "1"

  # 起動するECSタスクのタスク定義
  task_definition = aws_ecs_task_definition.app_task_def.arn

  # ECSタスクへ設定するネットワークの設定
  network_configuration {
    assign_public_ip = true
    # タスクの起動を許可するサブネット
    subnets = [var.public_a_subnet_id]
    # タスクに紐付けるセキュリティグループ
    security_groups = [var.app_access_security_group_id]
  }

  # ECSタスクの起動後に紐付けるELBターゲットグループ
  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  service_registries {
    registry_arn = aws_service_discovery_service.app_service_discovery.arn
  }

}

