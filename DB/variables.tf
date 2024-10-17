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

variable "monitoring_role_arn" {
  description = "IAM role ARN for RDS monitoring"
  type        = string
}

variable "sub_pri" {}

variable "sg-pri" {}

