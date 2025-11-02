# modules/vpc/outputs.tf

# 1. VPC ID Output
output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.this.vpc_id # References the output from the module block in main.tf
}

# 2. Private Subnets Output
output "private_subnets" {
  description = "List of IDs of private subnets."
  value       = module.this.private_subnets 
}

# 3. Public Subnets Output
output "public_subnets" {
  description = "List of IDs of public subnets."
  value       = module.this.public_subnets # References the output from the module block in main.tf
}