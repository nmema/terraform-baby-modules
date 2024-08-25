# VPC Module

This Terraform configuration sets up a Virtual Private Cloud with the following components:

- VPC: Creates a Virtual Private Cloud with a specified CIDR block.
- Subnets: Configures both public and private subnets within the VPC.
  - Public Subnets: Subnets that are accessible from the internet.
  - Private Subnets: Subnets that are isolated from the internet.
- Internet Gateway: Attaches an internet gateway to the VPC to enable internet access for public subnets.
- Public Route Table: Includes a route to the internet gateway for internet access.

![diagram](data/vpc.png)