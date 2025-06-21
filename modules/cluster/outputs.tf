output "ecs_cluster_id" {
  value = aws_ecs_cluster.main_ecs_cluster.id
}

output "ecs_service_discovery_id" {
  value = aws_service_discovery_private_dns_namespace.ecs_service_connect.id
}