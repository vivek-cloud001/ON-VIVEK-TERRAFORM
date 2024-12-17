# Ec2 Instance Web Tier
resource "aws_instance" "PublicWebTemplate" {
  ami                    = "ami-0440d3b780d96b29d"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-subnet-1.id
  key_name               = "dempkp"
  vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
  user_data              = file("install-apache.sh")

  tags = {
    Name = "web-sg"
  }
}

# Ec2 instance Application Tier
resource "aws_instance" "PrivateWebTemplate" {
  ami                    = "ami-0440d3b780d96b29d"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public-subnet-1.id
  key_name               = "dempkp"
  vpc_security_group_ids = [aws_security_group.ssh-security_group.id]
  user_data              = file("install-apache.sh")

  tags = {
    Name = "app-asg"
  }
}

