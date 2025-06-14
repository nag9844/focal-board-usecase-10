output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "focalboard_instance_id" {
  description = "The ID of the focalboard EC2 instance"
  value       = module.focalboard.instance_id
}


output "focalboard_url" {
  description = "URL to access focalboard through ALB"
  value       = "http://${module.alb.focalboard_dns_name}"
}
