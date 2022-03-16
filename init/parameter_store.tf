variable "mysql_password" {
  type = string
}
resource "aws_ssm_parameter" "secret" {
  name        = "/dev/mysql_rds_master_password"
  description = "Mysql DB password"
  type        = "SecureString"
  value       = var.mysql_password

  tags = {
    environment = "development"
  }
}
