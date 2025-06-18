resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
  service_connect_defaults {
    namespace = aws_service_discovery_private_dns_namespace.service_connect.arn
  }
}

resource "aws_service_discovery_private_dns_namespace" "service_connect" {
  name        = var.esc_service_discovery_namespace
  vpc         = var.vpc_id
  description = "Namespace for Service Connect"
}
