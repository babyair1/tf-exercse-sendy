resource "aws_vpc" "exercise-vpc" {
  cidr_block       = "24.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "exercise-vpc"
  }
}