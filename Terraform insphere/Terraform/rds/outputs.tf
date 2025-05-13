output "aurora_cluster_endpoint" {
  description = "The endpoint of the Aurora cluster."
  value       = aws_rds_cluster.aurora.endpoint
}

output "aurora_cluster_id" {
  description = "The ID of the Aurora DB cluster."
  value       = aws_rds_cluster.aurora.id
}

output "aurora_instance_ids" {
  description = "The IDs of the Aurora DB instances."
  value       = aws_rds_cluster_instance.aurora_instance.id
}

output "aurora_instance_endpoints" {
  description = "The endpoints of the Aurora DB instances."
  value       = aws_rds_cluster_instance.aurora_instance.endpoint
}