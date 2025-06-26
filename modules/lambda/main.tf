resource "aws_lambda_function" "point_service_batch" {
  function_name = var.function-name
  package_type  = "Image"
  image_uri     = var.lambda_image_uri
  role          = var.lambda_exec_role_arn

  timeout     = 30    # 最大実行時間（秒）
  memory_size = 512   # メモリサイズ（MB）

  vpc_config {
    subnet_ids         = [var.subnet_id_a, var.subnet_id_c]
    security_group_ids = [var.security_group_id]
  }

  environment {
    variables = var.lambda_environment
  }
}