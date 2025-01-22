## Terraformを操作

### 環境変数設定
1. terraform.tfvars を作成
2. variables.td の値を自環境に合わせて設定

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

### 認証ファイルや大きいサイズのファイルがコミット履歴に入った場合

```shell
git filter-repo --path 履歴から消したいファイル --invert-paths --force
```