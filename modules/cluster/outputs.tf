output "cluster_id" {
  description = "The ID of the ecs cluster"
  value = aws_ecs_cluster.main.id
}