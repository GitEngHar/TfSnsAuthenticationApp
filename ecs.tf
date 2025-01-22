resource "aws_ecs_cluster" "main" {
  name = "SnsAuthAppCluster"
}

resource "aws_ecs_task_definition" "main" {
  family                   = "SnsAuthAppTaskDef"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  execution_role_arn       = "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
  container_definitions    = <<EOL
[
  {
    "name": "springapp",
    "image": "${var.aws_account_id}.dkr.ecr.ap-northeast-1.amazonaws.com/sbs-authentication-app:latest",
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ]
  }
]
EOL
}

# https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html
resource "aws_lb_listener_rule" "main" {
  # ルールを追加するリスナー
  listener_arn = aws_lb_listener.test_listener.arn

  # 受け取ったトラフィックをターゲットグループへ受け渡す
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip-example.arn
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
  name = "SnsAuthAppSvc"

  # 依存関係の記述。
  # "aws_lb_listener_rule.main" リソースの作成が完了するのを待ってから当該リソースの作成を開始する。
  # "depends_on" は "aws_ecs_service" リソース専用のプロパティではなく、Terraformのシンタックスのため他の"resource"でも使用可能
  depends_on = [aws_lb_listener_rule.main]

  # 当該ECSサービスを配置するECSクラスターの指定
  cluster = aws_ecs_cluster.main.name

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
    subnets = [aws_subnet.public.id, aws_subnet.public-c.id]
    # タスクに紐付けるセキュリティグループ
    security_groups = [aws_security_group.sns-authentication-app-ecs.id]
  }

  # ECSタスクの起動後に紐付けるELBターゲットグループ
  load_balancer {
    target_group_arn = aws_lb_target_group.ip-example.arn
    container_name   = "springapp"
    container_port   = "8080"
  }

}



