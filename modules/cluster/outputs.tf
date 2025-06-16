output "cluster_id" {
  description = "The ID of the ecs cluster"
  value = aws_ecs_cluster.main.id
}

output "dns_service_connect" {
  description = ""
  value = aws_service_discovery_private_dns_namespace.service_connect.name
}