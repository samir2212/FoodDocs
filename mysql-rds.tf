module "mysql-rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.5.0"
  identifier = "${var.project}-${local.stage_name}-mysql-rds"
  storage_type= "gp2"
  allocated_storage = "20"
  max_allocated_storage = "40"
  create_db_parameter_group = false
  engine = "mysql"
  major_engine_version = "8.0"
  engine_version = "8.0.28"
  instance_class = "db.t3.micro"
  port = "3306"

  create_db_subnet_group = true
  subnet_ids = [aws_subnet.private_subnet1.id,aws_subnet.private_subnet2.id]

  username = var.username
  password = data.aws_ssm_parameter.mysql_rds_master_password.value

  backup_retention_period = 7
  create_monitoring_role =  true
  deletion_protection = false
  ##### change in prod ####
  #final_snapshot_identifier_prefix = "final"
  monitoring_interval = 5
  monitoring_role_name = "MyRDSMonitoringRole"
  tags = {
    Environment = "dev"
  }

  multi_az = true
  vpc_security_group_ids = ["${aws_security_group.mysql-rds-sg.id}"]
}


# ECS to RDS
resource "aws_security_group"  "mysql-rds-sg" {
  name        = "TF:SG:${var.project}-${local.stage_name}:mysql-rds-sg"
  description = "allow inbound access from the ECS tasks only"
  vpc_id      =  aws_vpc.vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = "3306"
    to_port         = "3306"
    security_groups = [aws_security_group.security_group.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

