resource "aws_lambda_function" "point_service_batch" {
  function_name = var.function-name
  role          = var.lambda_exec_role_arn
  runtime       = "provided.al2"
  handler       = "bootstrap"

  # ここを path.module から変数に切り替え
  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)
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

resource "aws_lambda_function" "point_service_batch" {
  function_name = var.function-name
  role          = var.lambda_exec_role_arn
  runtime       = "provided.al2"
  handler       = "bootstrap"

  # ここを path.module から変数に切り替え
  filename         = var.lambda_zip_path
  source_code_hash = filebase64sha256(var.lambda_zip_path)
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