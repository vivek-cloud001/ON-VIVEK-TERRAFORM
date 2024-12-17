# DB Subnet Group
resource "aws_db_subnet_group" "database-subnet-group" {
  subnet_ids  = [aws_subnet.private-db-subnet-1.id, aws_subnet.private-db-subnet-2.id]
  name        = "database subnets"
  description = "Subnet group for db instances"

  tags = {
    Name = "Database Subnets"
  }
}

# Database Subnets
resource "aws_db_instance" "database_instance" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = var.database-instance-class
  db_name                = "demodb"
  username               = "admin"
  password               = "password"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.database-subnet-group.name
  multi_az               = var.multi-az-deployment
  vpc_security_group_ids = [aws_security_group.database-security-group.id]

}