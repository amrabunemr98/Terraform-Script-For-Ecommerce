# Installing proiveder plugin
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "Terraform"
}

#***********************Inserting VPC****************************************
module "tf-vpc" {
  source     = "./VPC"
  cidr-block = var.cidr-block
  vpc-tag    = var.vpc-tag
}


#***********************Inserting Subnets************************************
module "tf-subnet" {
  source = "./Subnet"
  vpc    = module.tf-vpc.vpc
  sub    = var.sub
  sub-db = var.sub-db
}


#***********************Inserting SG****************************************
module "tf-security-group" {
  source  = "./SG"
  vpc     = module.tf-vpc.vpc
  cidr-SG = var.cidr-SG
}


#***********************Inserting IGW***************************************
module "tf-igw" {
  source           = "./IGW"
  vpc              = module.tf-vpc.vpc
  internet-gateway = var.internet-gateway

}


#***********************Inserting RT****************************************
module "tf-route-table" {
  source     = "./RT"
  vpc        = module.tf-vpc.vpc
  sub_pub    = [ module.tf-subnet.sub-pub ]
  cidr-rt    = var.cidr-rt
  igw        = module.tf-igw.igw
  tag_public = var.tag_public
}


#***********************Inserting Instance**********************************
module "tf-instance" {
  source           = "./EC2"
  sub_pub          = [ module.tf-subnet.sub-pub ]
  sg-pub           = module.tf-security-group.sg-pub
  ec2-type = var.type-ec2
  profile_instance = "Terraform"
  key-pair = var.key-pair
}


#***********************CloudWatch******************************************
module "tf-cloudwatch" {
  source = "./CloudWatch"
  ec2    = module.tf-instance.ec2_id[0]
  email  = var.email
  time   = var.time
}


#***********************Inserting DB******************************************
module "tf-RDS-MYSQL" {
  source = "./DB"
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  allocated_storage    = var.allocated_storage
  instance_class       = var.instance_class
  engine_version       = var.engine_version
  sub_pri              = module.tf-subnet.sub-pri
  sg-pri               = module.tf-security-group.sg-pri
  monitoring_role_arn  = module.tf-cloudwatch.monitoring_role_arn
}