### Route Table association for App Tier
resource "aws_route_table_association" "nat_route_1" {
  subnet_id      = aws_subnet.private-app-sbunet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "nat_route-2" {
  subnet_id      = aws_subnet.private-app-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}

## Route table association for DB Tier
resource "aws_route_table_association" "nat_route_db_1" {
  subnet_id      = aws_subnet.private-db-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "nat_route_db_2" {
  subnet_id      = aws_subnet.private-db-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}