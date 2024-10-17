#######################
#         Provider    #
#######################

variable "region" {
  description = "Region of AWS"
  type        = string
}

#######################
#         Vpc         #
#######################

variable "cidr-block" {
  description = "cidr of VPC"
  type        = string
}
variable "vpc-tag" {
  description = "name of vpc"
  type        = string
}

#######################
#         EC2         #
#######################

variable "type-ec2" {
  description = "size of EC2"
  type        = string
}
variable "key-pair" {
  description = "key pair of ec2"
  type        = string
}

#######################
#         Subnet      #
#######################

variable "sub" {
  description = "Public Subnet"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
}

variable "sub-db" {
  description = "Private Subnet"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
}
#######################
#    Security Group   #
#######################

variable "cidr-SG" {
  description = "cidar of SG"
  type        = list(string)
}

#######################
#   Internet Gateway  #
#######################

variable "internet-gateway" {
  description = "name of IGW"
  type        = string
}

#######################
#     Route Table     #
#######################

variable "cidr-rt" {
  description = "cidr-block of Route Table"
  type        = string
}
variable "tag_public" {}

#######################
#     CloudWatch      #
#######################

variable "email" {
  description = "Email For SNS Topic Subscription "
  type        = string
}
variable "time" {
  description = "Time of CloudWatch Alarm "
  type        = string
}

#######################
#     RDS-MYSQL       #
#######################

variable "db_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "username" {
  description = "Username for the MySQL database"
  type        = string
}

variable "password" {
  description = "Password for the MySQL database"
  type        = string
}

variable "allocated_storage" {
  description = "Storage allocated to the MySQL database (in GB)"
  type        = number
}

variable "instance_class" {
  description = "The instance type of the MySQL RDS"
  type        = string
}

variable "engine_version" {
  description = "The version of the MySQL engine"
  type        = string
}


