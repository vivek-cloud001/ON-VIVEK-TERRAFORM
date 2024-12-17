## VPC

variable "aws_vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC_CIDR_BLOCK"
  type        = string
}
#variable "AZ" { }
variable "enable_dns_support" {
  type    = bool
  default = true
}
variable "dns_host_name" {
  type    = bool
  default = true
}

variable "vpc-name" {
  type    = string
  default = "demovpc"
}

## Internet Gateway
variable "ig-name" {
  type    = string
  default = "demoIG"
}

#####Subnets#######
###################

# Public Subnet
variable "public-subnet-1-cidr" {
  default     = "10.0.1.0/24"
  type        = string
  description = "public_web_subnet-1"
}
variable "public-subnet-2-cidr" {
  default     = "10.0.2.0/24"
  type        = string
  description = "public-web-subnet-2"
}

# Private Subnet (Application Layer)
variable "private-app-subnet-1-cidr" {
  default     = "10.0.3.0/24"
  type        = string
  description = "private-app-subnet-1"
}
variable "private-app-subnet-2-cidr" {
  default     = "10.0.4.0/24"
  type        = string
  description = "private-app-subnet-2"
}

#Private-db-subnets (DB Layer)
variable "private-db-subnet-1-cidr" {
  default     = "10.0.5.0/24"
  type        = string
  description = "private-db-subnet-1"
}
variable "private-db-subnet-2-cidr" {
  default     = "10.0.6.0/24"
  type        = string
  description = "private-db-subnet-2"
}

###My IP #####
variable "myip" {
  default     = "217.96.246.143/32"
  description = "my IP "
  type        = string

}

# DB instance class
variable "database-instance-class" {
  default     = "db.t2.micro"
  description = "Database instance type"
  type        = string
}

# Multi-availability-enable
variable "multi-az-deployment" {
  default     = true
  type        = bool
  description = "Create a standby DB Instance"
}