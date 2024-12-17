resource "aws_eip" "eip_nat" {
  domain = "vpc"

  tags = {
    Name = "eip1"
  }
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public-subnet-2.id

  tags = {
    Name = "Nat Gateway 1"
  }
}

