resource "aws_elasticache_subnet_group" "redis" {
  name       = "${var.redis_cluster_id}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.redis_cluster_id
  engine               = "redis"
  engine_version       = var.engine_version
  node_type            = var.redis_node_type
  num_cache_nodes      = 1
  port                 = 6379
  subnet_group_name    = aws_elasticache_subnet_group.redis.name
  security_group_ids   = var.redis_security_group_ids
  parameter_group_name = "default.redis7"
}