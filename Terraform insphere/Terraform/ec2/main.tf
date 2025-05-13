# Create Application Load Balancer
resource "aws_lb" "this" {
  name                        = var.lb_name
  internal                    = var.lb_internal
  load_balancer_type          = var.lb_type
  security_groups             = var.lb_security_groups
  subnets                     = var.lb_subnets
  enable_deletion_protection  = var.lb_enable_deletion_protection
}

# Create Target Group for Load Balancer
resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.target_group_vpc_id

  health_check {
    path                = var.health_check_path
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
    protocol            = var.health_check_protocol
  }
}

# Create Instance Profile
resource "aws_iam_instance_profile" "this" {
  name = "my-instance-profile"
  role = var.launch_template_instance_profile
}

# Create Launch Template
resource "aws_launch_template" "this" {
  name_prefix   = var.launch_template_name_prefix
  image_id      = var.launch_template_image_id
  instance_type = var.launch_template_instance_type
  vpc_security_group_ids = var.launch_template_security_group

  iam_instance_profile {
    name = aws_iam_instance_profile.this.name
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.launch_template_tags
  }
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "this" {
  desired_capacity     = var.asg_desired_capacity
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  launch_template {
    id                 = aws_launch_template.this.id
    version            = "$Latest"
  }
  vpc_zone_identifier  = var.asg_subnets

  target_group_arns = [aws_lb_target_group.this.arn]

  health_check_type          = var.asg_health_check_type
  health_check_grace_period = var.asg_health_check_grace_period
  force_delete              = var.asg_force_delete
}

# Attach the Target Group to the Load Balancer Listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}