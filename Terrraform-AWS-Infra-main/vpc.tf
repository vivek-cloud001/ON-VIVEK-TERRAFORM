## Private VPC ## 
resource "aws_vpc" "private_vpc" {
  cidr_block           = var.aws_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "demovpc"
  }
}
