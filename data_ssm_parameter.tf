data "aws_ssm_parameter" "mysql_rds_master_password" {
  name = "/dev/mysql_rds_master_password"
}
