# ASG for Presentation Tier
resource "aws_launch_template" "auto-scaling-group" {
  name_prefix   = "auto-scaling-group"
  image_id      = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  user_data     = filebase64("install-apache.sh")
  key_name      = "dempkp"
  network_interfaces {
    subnet_id       = aws_subnet.public-subnet-1.id
    security_groups = [aws_security_group.webserver-security-group.id]

  }
}
resource "aws_autoscaling_group" "asg-1" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.auto-scaling-group.id
    version = "$Latest"
  }
}

# ASG for Application Tier
resource "aws_launch_template" "auto-scaling-group-private" {
  name_prefix   = "auto-scaling-group-private"
  image_id      = "ami-0440d3b780d96b29d"
  instance_type = "t2.micro"
  user_data     = filebase64("install-apache.sh")
  key_name      = "dempkp"
  network_interfaces {
    subnet_id       = aws_subnet.private-app-sbunet-1.id
    security_groups = [aws_security_group.ssh-security_group.id]

  }
}
resource "aws_autoscaling_group" "asg-2" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  launch_template {
    id      = aws_launch_template.auto-scaling-group-private.id
    version = "$Latest"
  }
}