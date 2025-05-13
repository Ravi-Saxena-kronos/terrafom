# Load Balancer Variables
variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
  default     = "my-load-balancer"
}

variable "lb_internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "The type of the load balancer (application, network)"
  type        = string
  default     = "application"
}

variable "lb_security_groups" {
  description = "List of security groups associated with the load balancer"
  type        = list(string)
}

variable "lb_subnets" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "lb_enable_deletion_protection" {
  description = "Whether deletion protection is enabled"
  type        = bool
  default     = false
}

# Target Group Variables
variable "target_group_name" {
  description = "The name of the target group"
  type        = string
  default     = "my-target-group"
}

variable "target_group_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_group_protocol" {
  description = "The protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "target_group_vpc_id" {
  description = "The VPC ID for the target group"
  type        = string
}

variable "health_check_path" {
  description = "The path for the health check"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "Interval for the health check"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "Timeout for the health check"
  type        = number
  default     = 5
}

variable "health_check_healthy_threshold" {
  description = "Healthy threshold for the health check"
  type        = number
  default     = 2
}

variable "health_check_unhealthy_threshold" {
  description = "Unhealthy threshold for the health check"
  type        = number
  default     = 2
}

variable "health_check_protocol" {
  description = "Protocol for the health check"
  type        = string
  default     = "HTTP"
}

# Launch Template Variables
variable "launch_template_name_prefix" {
  description = "The name prefix for the launch template"
  type        = string
  default     = "my-launch-template-"
}

variable "launch_template_image_id" {
  description = "The AMI ID for the launch template"
  type        = string
  default     = "ami-091dccf4e2d272bae"
}

variable "launch_template_instance_type" {
  description = "The instance type for the launch template"
  type        = string
  default     = "t2.micro"
}

variable "launch_template_instance_profile" {
  description = "The Name of instance Profile for the launch template"
  type        = string
  default     = ""
}

variable "launch_template_security_group" {
  description = "The Name of Security Group for the launch template to associate instance with"
  type        = list(string)
  default     = []
}

variable "launch_template_tags" {
  description = "Tags for the instances launched from the template"
  type        = map(string)
  default     = {
    Name = "AutoScalingInstance"
  }
}

# Auto Scaling Group Variables
variable "asg_desired_capacity" {
  description = "The desired capacity of the Auto Scaling group"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "The maximum size of the Auto Scaling group"
  type        = number
  default     = 3
}

variable "asg_min_size" {
  description = "The minimum size of the Auto Scaling group"
  type        = number
  default     = 1
}

variable "asg_subnets" {
  description = "List of subnets to use for the Auto Scaling group"
  type        = list(string)
  default     = ["subnet-062b6fe7c82c5b48d", "subnet-00d6eaee79136a5a6"]
}

variable "asg_health_check_type" {
  description = "The type of health check for the Auto Scaling group"
  type        = string
  default     = "EC2"
}

variable "asg_health_check_grace_period" {
  description = "The grace period for the health check"
  type        = number
  default     = 300
}

variable "asg_force_delete" {
  description = "Whether to force delete the Auto Scaling group when it is deleted"
  type        = bool
  default     = true
}

# Listener Variables
variable "listener_port" {
  description = "The port for the load balancer listener"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "The protocol for the listener"
  type        = string
  default     = "HTTP"
}