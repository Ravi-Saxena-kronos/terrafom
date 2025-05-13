resource "aws_security_group" "ALB-SG" {
  name        = "ALB-SG"
  description = "ALB-SG"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "ALB-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ALB-SG-ingress1" {
  security_group_id = aws_security_group.ALB-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "ALB-SG-ingress2" {
  security_group_id = aws_security_group.ALB-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "ALB-SG-egress1" {
  security_group_id = aws_security_group.ALB-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

#------------------------------------------------------------------------------------------------------------------#

resource "aws_security_group" "Server-SG" {
  name        = "Server-SG"
  description = "Server-SG"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "Server-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Server-SG-ingress1" {
  security_group_id = aws_security_group.Server-SG.id

  referenced_security_group_id = aws_security_group.ALB-SG.id
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "Server-SG-ingress2" {
  security_group_id = aws_security_group.Server-SG.id

  referenced_security_group_id = aws_security_group.ALB-SG.id
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "Server-SG-ingress3" {
  security_group_id = aws_security_group.VPN-SG.id

  referenced_security_group_id = aws_security_group.VPN-SG.id
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "Server-SG-egress1" {
  security_group_id = aws_security_group.Server-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

#------------------------------------------------------------------------------------------------------------------#

resource "aws_security_group" "VPN-SG" {
  name        = "VPN-SG"
  description = "VPN-SG"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "VPN-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "VPN-SG-ingress1" {
  security_group_id = aws_security_group.VPN-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port = 1194
  ip_protocol = "udp"
  to_port = 1194
}

resource "aws_vpc_security_group_ingress_rule" "VPN-SG-ingress2" {
  security_group_id = aws_security_group.VPN-SG.id

  referenced_security_group_id = aws_security_group.VPN-SG.id
  from_port   = 12320
  ip_protocol = "tcp"
  to_port     = 12321
}

resource "aws_vpc_security_group_ingress_rule" "VPN-SG-ingress3" {
  security_group_id = aws_security_group.VPN-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port = 443
  ip_protocol = "tcp"
  to_port = 443
}

resource "aws_vpc_security_group_ingress_rule" "VPN-SG-ingress4" {
  security_group_id = aws_security_group.VPN-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port = 80
  ip_protocol = "tcp"
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "VPN-SG-ingress5" {
  security_group_id = aws_security_group.VPN-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_egress_rule" "VPN-SG-egress1" {
  security_group_id = aws_security_group.VPN-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

#------------------------------------------------------------------------------------------------------------------#

resource "aws_security_group" "Redis-SG" {
  name        = "Redis-SG"
  description = "Redis-SG"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "Redis-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "Redis-SG-ingress1" {
  security_group_id = aws_security_group.Redis-SG.id

  referenced_security_group_id = aws_security_group.Server-SG.id
  from_port = 6379
  ip_protocol = "tcp"
  to_port = 6379
}

resource "aws_vpc_security_group_ingress_rule" "Redis-SG-ingress2" {
  security_group_id = aws_security_group.Redis-SG.id

  referenced_security_group_id = aws_security_group.VPN-SG.id
  from_port   = 6379
  ip_protocol = "tcp"
  to_port     = 6379
}

resource "aws_vpc_security_group_egress_rule" "Redis-SG-egress1" {
  security_group_id = aws_security_group.Redis-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

#------------------------------------------------------------------------------------------------------------------#

resource "aws_security_group" "RDS-SG" {
  name        = "RDS-SG"
  description = "RDS-SG"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name = "RDS-SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "RDS-SG-ingress1" {
  security_group_id = aws_security_group.RDS-SG.id

  referenced_security_group_id = aws_security_group.Server-SG.id
  from_port = 3306
  ip_protocol = "tcp"
  to_port = 3306
}

resource "aws_vpc_security_group_ingress_rule" "RDS-SG-ingress2" {
  security_group_id = aws_security_group.RDS-SG.id

  referenced_security_group_id = aws_security_group.VPN-SG.id
  from_port   = 3306
  ip_protocol = "tcp"
  to_port     = 3306
}

resource "aws_vpc_security_group_egress_rule" "RDS-SG-egress1" {
  security_group_id = aws_security_group.RDS-SG.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}