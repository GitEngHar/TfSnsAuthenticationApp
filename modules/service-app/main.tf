resource "aws_ecs_task_definition" "main" {
  family                   = var.task_def_family_name
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  container_definitions    = jsonencode([
    {
      name  = var.name_of_container
      image = "${var.aws_account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/${var.container_image_name}"
      portMappings = [
        {
          containerPort = var.app-to-port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = var.ecs_log_group_name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "my-app"
        }
      }
      environment = var.container_environment
    }
  ])
}

# https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html
resource "aws_lb_listener_rule" "main" {
  # ルールを追加するリスナー
  listener_arn = var.arn_ecs_app_listener

  # 受け取ったトラフィックをターゲットグループへ受け渡す
  action {
    type             = "forward"
    target_group_arn = var.arn_lb_target_group
  }

  # ターゲットグループへ受け渡すトラフィックの条件
  condition {
    path_pattern {
      values = ["*"]
    }
  }
}


# https://www.terraform.io/docs/providers/aws/r/ecs_service.html
resource "aws_ecs_service" "main" {
  name = var.name_of_service

  # 依存関係の記述。
  # "aws_lb_listener_rule.main" リソースの作成が完了するのを待ってから当該リソースの作成を開始する。
  # "depends_on" は "aws_ecs_service" リソース専用のプロパティではなく、Terraformのシンタックスのため他の"resource"でも使用可能
  depends_on = [aws_lb_listener_rule.main]

  # 当該ECSサービスを配置するECSクラスターの指定
  cluster = var.id_of_ecs_cluster

  # データプレーンとしてFargateを使用する
  launch_type = "FARGATE"

  # ECSタスクの起動数を定義
  desired_count = "1"

  # 起動するECSタスクのタスク定義
  task_definition = aws_ecs_task_definition.main.arn

  # ECSタスクへ設定するネットワークの設定
  network_configuration {
    assign_public_ip = true
    # タスクの起動を許可するサブネット
    subnets = [var.public-a_id, var.public-a_id]
    # タスクに紐付けるセキュリティグループ
    security_groups = [var.sg_id_for_ecs]
  }

  # ECSタスクの起動後に紐付けるELBターゲットグループ
  load_balancer {
    target_group_arn = var.arn_lb_target_group
    container_name   = var.name_of_container
    container_port   = var.app-to-port
  }

}

