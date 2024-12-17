resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.private_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = {
    Name = "Private Route Table"
  }
}
