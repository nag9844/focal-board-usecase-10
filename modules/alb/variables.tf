variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "The IDs of the public subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group for the ALB"
  type        = string
}

variable "focalboard_instance" {
  description = "The ID of the focalboard EC2 instance"
  type        = string
}
