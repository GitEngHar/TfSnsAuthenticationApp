## Terraformを操作

### 環境変数設定
1. terraform-sample.tfvars を terraform.tfvars へ変更
2. terraform.tfvars の値を自環境に合わせて変更

### Terraform

初期化
```shell
terraform init
```

書式を整える
```shell
terraform fmt
```

awsとの差分を確認
```shell
terraform plan
```

リソースを構築・変更
```shell
terraform apply
```

リソースを削除
```shell
terraform destroy
```

## GitTips

### 認証ファイル等が追跡対象に入った場合