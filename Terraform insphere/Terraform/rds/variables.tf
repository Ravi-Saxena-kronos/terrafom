variable "db_cluster_identifier" {
  description = "The identifier for the Aurora DB cluster."
  type        = string
  default     = "aurora-cluster"
}

variable "engine" {
  description = "The Aurora engine (e.g., aurora-mysql, aurora-postgresql)."
  type        = string
  default     = "aurora-mysql"
}

variable "instance_class" {
  description = "The instance class for the Aurora instances."
  type        = string
  default     = "db.t3.medium"
}

variable "username" {
  description = "The master username for the Aurora database."
  type        = string
  default     = "admin"
}

variable "password" {
  description = "The master password for the Aurora database."
  type        = string
  sensitive   = true
  default     = "admin123"
}

variable "vpc_security_group_ids" {
  description = "The security group IDs to associate with the Aurora cluster."
  type        = list(string)
}

# variable "db_subnet_group_name" {
#   description = "The name of the DB subnet group."
#   type        = string
# }

variable "allocated_storage" {
  description = "The amount of storage to allocate for the database (in GB)."
  type        = number
  default     = 20
}

# variable "backup_retention_period" {
#   description = "The number of days to retain automated backups."
#   type        = number
#   default     = 7
# }

variable "subnet_ids" {
  description = "Subnet id's for db subnet group"
  type        = list(string)
}


variable "skip_final_snapshot" {
  description = "Skip final snapshot before deletion"
  type        = bool
  default     = true
}
