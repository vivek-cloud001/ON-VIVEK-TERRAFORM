###########################################
#### SG Application Tier (Bastion Host)####
###########################################
resource "aws_security_group" "ssh-security_group" {
  name        = "SSH Access"
  description = "Enable SSH Access on port 22"
  vpc_id      = aws_vpc.private_vpc.id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.myip}"]
  }
  tags = {
    Name = "ssh access"
  }
}