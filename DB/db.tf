resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql-subnet-group"
  subnet_ids = var.sub_pri
}

# MySQL RDS Instance
resource "aws_db_instance" "mysql_db" {
  allocated_storage    = var.allocated_storage
  engine               = "mysql"
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [var.sg-pri]
  skip_final_snapshot  = true
  publicly_accessible = false

  # CloudWatch Monitoring
  monitoring_interval    = 1  # 1-minute interval
  monitoring_role_arn    = var.monitoring_role_arn

  tags = {
    Name = var.db_name
  }
}
