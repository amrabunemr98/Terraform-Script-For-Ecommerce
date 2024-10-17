#######################
#         Provider    #
#######################

region = "us-west-1"

#######################
#         Vpc         #
#######################

cidr-block = "10.0.0.0/16"

vpc-tag = "Project"

#######################
#         Subnet      #
#######################

sub = {
  "public-subnet-1" = {
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-west-1a"
    name              = "public-Sub-1"
  }
  "public-subnet-2" = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-west-1b"
    name              = "public-Sub-2"
  }
}

sub-db = {
  "private-subnet-1" = {
    cidr_block        = "10.0.0.0/24"
    availability_zone = "us-west-1a"
    name              = "private-Sub-1"
  }
  "private-subnet-2" = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-west-1b"
    name              = "private-Sub-2"
  }
}

#######################
#    Security Group   #
#######################

cidr-SG = ["0.0.0.0/0"]

#######################
#   Internet Gateway  #
#######################

internet-gateway = "Project-IGW"

#######################
#     Route Table     #
#######################

cidr-rt    = "0.0.0.0/0"
tag_public = "public RT"

#######################
#         EC2         #
#######################

type-ec2 = "t2.micro"
key-pair = "Project"

#######################
#     CloudWatch      #
#######################

email = "amr_abunemr16@yahoo.com"
time  = "300" # it's 300 sec = 5 mins

#######################
#     RDS-MYSQL       #
#######################

db_name           = "mysql-database"
username          = "admin"
password          = "MySecurePassword123"
allocated_storage = 20
instance_class    = "db.t2.micro"
engine_version    = "8.0"

