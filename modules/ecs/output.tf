# output "cluster_name" {
#     value = aws_ecs_cluster.main.name
# }

output "cluster_id" {
    value = aws_ecs_cluster.main.id
}

output "task_definition_arn" {
    value = aws_ecs_task_definition.main.arn
}