variable "vpc_id" {
  description = "VPC ID where Redis should be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the Redis subnet group"
  type        = list(string)
}

variable "redis_cluster_id" {
  description = "Name of the Redis cluster"
  type        = string
}

variable "redis_node_type" {
  description = "Instance type for Redis nodes"
  type        = string
  default     = "cache.t3.micro"
}

variable "engine_version" {
  description = "Redis engine version"
  type        = string
  default     = "7.0"
}

variable "redis_security_group_ids" {
  description = "The security group IDs to associate with Redis cluster."
  type        = list(string)
}