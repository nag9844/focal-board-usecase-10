# tests/existing_infra_test.tftest.hcl

# We only need a 'run' block with 'command = plan' or 'command = apply'
# to trigger the evaluation of data sources and assertions.
# 'plan' is usually sufficient here as we're not creating anything.
run "validate_existing_vpc_and_instance" {
  command = plan # Or 'apply' if you need to run something dynamic, but 'plan' is generally fine for data sources.

  # --- Data Sources to reference existing infrastructure ---

  # Reference an existing VPC by tag or ID
  data "aws_vpc" "production_vpc" {
    tags = {
      Name = "my-production-vpc" # Replace with actual tag or id
    }
  }

  # Reference an existing Subnet within that VPC
  data "aws_subnet" "production_subnet" {
    filter {
      name   = "vpc-id"
      values = [data.aws_vpc.production_vpc.id]
    }
    tags = {
      Name = "my-production-app-subnet" # Replace with actual tag or id
    }
  }

  # Reference an existing EC2 instance by tag or ID
  data "aws_instance" "production_app_server" {
    filter {
      name   = "tag:Name"
      values = ["my-production-app-server"] # Replace with actual tag or id
    }
    filter {
      name   = "instance-state-name"
      values = ["running"]
    }
  }

  # --- Assertions against the attributes of the existing resources ---

  assert {
    condition     = data.aws_vpc.production_vpc.id != null
    error_message = "Production VPC 'my-production-vpc' not found."
  }

  assert {
    condition     = data.aws_vpc.production_vpc.cidr_block == "10.0.0.0/16" # Validate its CIDR block
    error_message = "Production VPC CIDR block is not 10.0.0.0/16."
  }

  assert {
    condition     = data.aws_subnet.production_subnet.vpc_id == data.aws_vpc.production_vpc.id
    error_message = "Production Subnet is not associated with the correct VPC."
  }

  assert {
    condition     = data.aws_instance.production_app_server.instance_type == "t3.medium" # Validate instance type
    error_message = "Production app server is not a t3.medium instance."
  }

  assert {
    condition     = contains(data.aws_instance.production_app_server.private_ips, "10.0.1.10") # Validate a specific IP
    error_message = "Production app server does not have the expected private IP."
  }
}