output "load_balancer_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.this.arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

output "autoscaling_group_id" {
  description = "The ID of the Auto Scaling group"
  value       = aws_autoscaling_group.this.id
}