output "instance_id" {
  description = "The ID of the focalboard EC2 instance"
  value       = aws_instance.focalboard.id
}

output "private_ip" {
  description = "The private IP of the focalboard EC2 instance"
  value       = aws_instance.focalboard.private_ip
}

output "public_ip" {
  description = "The public IP of the focalboard EC2 instance"
  value       = aws_instance.focalboard.public_ip
}