module "vpc" {
  source = "./vpc"
}

module "rds_aurora" {
  source                 = "./rds"
  db_cluster_identifier  = "my-aurora-cluster"
  engine                 = "aurora-mysql"
  username               = "admin"
  password               = "secret-password"
  vpc_security_group_ids = [aws_security_group.RDS-SG.id]
  subnet_ids             = module.vpc.private_subnet_ids
}

module "ec2" {
  source                           = "./ec2"
  launch_template_security_group   = [aws_security_group.Server-SG.id]
  launch_template_instance_profile = aws_iam_role.ec2_role.name
  lb_security_groups               = [aws_security_group.ALB-SG.id]
  lb_subnets                       = module.vpc.public_subnet_ids
  target_group_vpc_id              = module.vpc.vpc_id
  asg_subnets                      = module.vpc.private_subnet_ids
}

module "elasticache" {
  source                   = "./elasticache"
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnet_ids
  redis_cluster_id         = "my-redis"
  redis_node_type          = "cache.t3.micro"
  engine_version           = "7.0"
  redis_security_group_ids = [aws_security_group.Redis-SG.id]
}
