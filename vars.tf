variable "subnet_cidr" {
  type = "list"
  default = ["10.0.0.0/24", "10.0.1.0/24" ]
}

variable "azs" {
  type = "list"
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "ami_linux" {
  default = "ami-5a8da735"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "rds_cidr" {
  type = "list"
  default = ["10.0.2.0/24", "10.0.3.0/24" ]
}

#Get list of AZ's in a regions
#data "aws_availability_zones" "azs" {}
