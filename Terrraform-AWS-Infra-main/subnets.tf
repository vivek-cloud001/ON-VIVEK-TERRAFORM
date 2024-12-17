
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.public-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.public-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2"
  }
}

####Application Layer Private Subnets #######

resource "aws_subnet" "private-app-sbunet-1" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.private-app-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false


  tags = {
    Name = "Application Private Subnet 1"
  }
}

resource "aws_subnet" "private-app-subnet-2" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.private-app-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Application Private Subnet 2"
  }
}


####### DB layer Subnets ##########
resource "aws_subnet" "private-db-subnet-1" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.private-db-subnet-1-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "DB Private Subnet 1"
  }

}

resource "aws_subnet" "private-db-subnet-2" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.private-db-subnet-2-cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "DB Private Subnet 2"
  }

}