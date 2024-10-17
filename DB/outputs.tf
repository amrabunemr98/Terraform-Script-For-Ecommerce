output "rds_endpoint" {
  description = "The endpoint of the MySQL RDS instance"
  value       = aws_db_instance.mysql_db.endpoint
}

output "rds_instance_id" {
  description = "The ID of the MySQL RDS instance"
  value       = aws_db_instance.mysql_db.id
}
