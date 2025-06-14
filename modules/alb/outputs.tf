
output "focalboard_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.focalboard.dns_name
}

output "focalboard_target_group_arn" {
  description = "The ARN of the focalboard target group"
  value       = aws_lb_target_group.focalboard.arn
}

