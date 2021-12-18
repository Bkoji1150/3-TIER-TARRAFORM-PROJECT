#### ----- database/main.tf ------

resource "aws_db_instance" "postgres_rd" {
  allocated_storage = var.db_storage
  engine            = "mysql"
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  name              = var.name
  username          = var.username
  password          = var.password
  ##parameter_group_name = var.db_parameter_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  identifier             = var.identifier
  skip_final_snapshot    = var.skip_db_snapshot
  db_subnet_group_name   = var.db_subnet_group_name
  multi_az               = var.multi_az
  tags = {
    name = "mypostgresdb"
  }
}

/*resource "aws_db_parameter_group" "Project-Omega-db-parameterGroup" {
  #name   = "rds-pg"
  family = var.dbprameter_family #"mysql5.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}
*/