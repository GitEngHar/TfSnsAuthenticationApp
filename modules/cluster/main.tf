resource "aws_ecs_cluster" "main" {
  name = var.name_of_cluster
  service_connect_defaults {
    namespace = aws_service_discovery_private_dns_namespace.service_connect.arn
  }
}

# -------------------------
# Service Connect 用の Cloud Map 名前空間
# -------------------------
resource "aws_service_discovery_private_dns_namespace" "service_connect" {
  name        = "pointservice.local"
  vpc         = var.vpc_id
  description = "Namespace for Service Connect"
}
