resource "aws_db_subnet_group" "app_db_subnet_group" {
  name       = "app-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "Aurora-Subnet-Group"
  }
}

# Create the Aurora DB cluster
resource "aws_rds_cluster" "aurora" {
  cluster_identifier = var.db_cluster_identifier
  engine             = var.engine
  # database_name         = "mydatabase"
  master_username         = var.username
  master_password         = var.password
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  storage_encrypted       = true
  db_subnet_group_name    = aws_db_subnet_group.app_db_subnet_group.id
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = true
  tags = {
    Name = "MyAuroraCluster"
  }
  lifecycle {
    prevent_destroy = false
  }
}

# Create an Aurora instance for the cluster
resource "aws_rds_cluster_instance" "aurora_instance" {
  cluster_identifier   = aws_rds_cluster.aurora.id
  instance_class       = var.instance_class
  engine               = var.engine
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.app_db_subnet_group.id

  tags = {
    Name = "AuroraInstance-${var.db_cluster_identifier}"
  }
}
