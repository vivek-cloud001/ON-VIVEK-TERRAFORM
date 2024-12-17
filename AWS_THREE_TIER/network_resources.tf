# VPC
resource "aws_vpc" "three-tier-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "three-tier-vpc"
  }
}

# Public Subnets 
resource "aws_subnet" "three-tier-pub-sub-1" {
  vpc_id            = aws_vpc.three-tier-vpc.id
  cidr_block        = "10.0.0.0/28"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "three-tier-pub-sub-1"
  }
}

resource "aws_subnet" "three-tier-pub-sub-2" {
  vpc_id            = aws_vpc.three-tier-vpc.id
  cidr_block        = "10.0.0.16/28"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "three-tier-pub-sub-2"
  }
}


# Private Subnets
resource "aws_subnet" "three-tier-pvt-sub-1" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "10.0.0.32/28"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-1"
  }
}
resource "aws_subnet" "three-tier-pvt-sub-2" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "10.0.0.48/28"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-2"
  }
}

resource "aws_subnet" "three-tier-pvt-sub-3" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "10.0.0.64/28"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-3"
  }
}
resource "aws_subnet" "three-tier-pvt-sub-4" {
  vpc_id                  = aws_vpc.three-tier-vpc.id
  cidr_block              = "10.0.0.80/28"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "three-tier-pvt-sub-4"
  }
}

#Create an ec2 auto scaling group
resource "aws_autoscaling_group" "three-tier-web-asg" {
  name                 = "three-tier-web-asg"
  launch_configuration = aws_launch_configuration.three-tier-web-lconfig.id
  vpc_zone_identifier  = [aws_subnet.three-tier-pub-sub-1.id, aws_subnet.three-tier-pub-sub-2.id]
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}

###### Create a launch configuration for the EC2 instances #####
resource "aws_launch_configuration" "three-tier-web-lconfig" {
  name_prefix                 = "three-tier-web-lconfig"
  image_id                    = "ami-0995922d49dc9a17d"
  instance_type               = "t2.micro"
  key_name                    = "three-key"
  security_groups             = [aws_security_group.three-tier-ec2-asg-sg.id]
  user_data                   = <<-EOF
                                #!/bin/bash
                                sudo yum -y update
                                sudo yum -y install httpd
                                sudo systemctl start httpd.service
                                sudo systemctl enable httpd.service
                                echo "<html><h1>Welcome to Apache web server on amazon linux!<h1><html>" > var/www/html/index.html
                                EOF

  associate_public_ip_address = true
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

# Create an EC2 Auto Scaling Group - app
resource "aws_autoscaling_group" "three-tier-app-asg" {
  name                 = "three-tier-app-asg"
  launch_configuration = aws_launch_configuration.three-tier-app-lconfig.id
  vpc_zone_identifier  = [aws_subnet.three-tier-pvt-sub-1.id, aws_subnet.three-tier-pvt-sub-2.id]
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
}

# Create a launch configuration for the EC2 instances
resource "aws_launch_configuration" "three-tier-app-lconfig" {
  name_prefix                 = "three-tier-app-lconfig"
  image_id                    = "ami-0995922d49dc9a17d"
  instance_type               = "t2.micro"
  key_name                    = "three-key"
  security_groups             = [aws_security_group.three-tier-ec2-asg-sg-app.id]
  user_data                   = <<-EOF
                                #!/bin/bash

                                sudo yum install mysql -y

                                EOF
                                
  associate_public_ip_address = false
  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}

#### RDS ####
resource "aws_db_subnet_group" "three-tier-db-sub-grp" {
  name       = "three-tier-db-sub-grp"
  subnet_ids = ["${aws_subnet.three-tier-pvt-sub-3.id}","${aws_subnet.three-tier-pvt-sub-4.id}"]
}

resource "aws_db_instance" "three-tier-db" {
  allocated_storage           = 100
  storage_type                = "gp3"
  engine                      = "mysql"
  engine_version              = "8.0"
  instance_class              = "db.t2.micro"
  identifier                  = "three-tier-db"
  username                    = "admin"
  password                    = "password"
  parameter_group_name        = "default.mysql8.0"
  db_subnet_group_name        = aws_db_subnet_group.three-tier-db-sub-grp.name
  vpc_security_group_ids      = ["${aws_security_group.three-tier-db-sg.id}"]
  multi_az                    = true
  skip_final_snapshot         = true
  publicly_accessible          = false

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }
}