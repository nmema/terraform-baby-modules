output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}

output "public_subnet_ids" {
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
  description = "IDs of the Public Subnets"
}

output "private_subnet_ids" {
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
  description = "IDs of the Private Subnets"
}
