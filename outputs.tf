output "Public-ip-instance" {
  value = module.tf-instance.Public-ip-instance
}

output "rds_endpoint" {
  value = module.tf-RDS-MYSQL.rds_endpoint
}

output "rds_instance_id" {
  description = "The ID of the MySQL RDS instance"
  value       = module.tf-RDS-MYSQL.rds_instance_id
}