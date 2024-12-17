resource "aws_security_group" "webserver-security-group" {
  name        = "Web Sever Security Group"
  description = "Enable HTTP/HTTPS access on port 80/443 via ALB and SSH vis SSH SG"
  vpc_id      = aws_vpc.private_vpc.id
  ingress {
    description     = "http access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

  ingress {
    description     = "https access"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = ["${aws_security_group.alb-security-group.id}"]
  }

  ingress {
    description     = "ssh access"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ssh-security_group.id}"]
  }

  tags = {
    Name = "Web server Security Group"
  }
}