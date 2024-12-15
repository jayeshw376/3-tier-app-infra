variable "aws_vpc" {
    description = "The ID of the VPC"
    type        = string
    default = "172.20.0.0/16"
  
}

variable "vpc_name" {
    description = "The name of the VPC"
    type        = string
    default = "3-tietr-vpc"
  
}
variable "ami" {
    description = "ami"
    type        = string
    default = "ami-055e3d4f0bbeb5878"
  
}
variable "instance-type" {
    description = " instance type "
    type        = string
    default = "t2.micro"
}
variable "key-name" {
    description = "key"
    type        = string
    default = "aws"
}
variable "rds-password" {
    description = "rds password"
    type = string
    default = "admin123"
  
}
variable "rds-username" {
    description = "rds username"
    type = string
    default = "admin"
  
}
