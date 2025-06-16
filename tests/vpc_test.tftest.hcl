# tests/vpc_test.tftest.hcl

# This 'run' block defines a test scenario.
# It will apply the module configuration.
run "vpc_creation" {
  command = apply

  # You can define variable values for the module under test here
  variables = {
    vpc_cidr = "10.0.0.0/16"
    # ... other module variables
  }

  # Assertions to check the expected outcomes after applying
  assert {
    condition     = module.vpc.vpc_id != null
    error_message = "VPC ID should not be null after creation"
  }

  assert {
    condition     = module.vpc.vpc_cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block should match the input"
  }

  assert {
    condition     = length(module.vpc.private_subnets_id) == 3
    error_message = "Should have 3 private subnets"
  }
}

# You can add more 'run' blocks for different scenarios (e.g., planning, edge cases)
# run "vpc_plan_validation" {
#   command = plan
#   variables = {
#     vpc_cidr = "10.0.0.0/16"
#   }
#   assert {
#     condition = length(terraform.resource_changes.aws_vpc.example.tags) == 1
#     error_message = "VPC should have 1 tag."
#   }
# }