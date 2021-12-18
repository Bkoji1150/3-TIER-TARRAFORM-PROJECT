### ----root/main.tf ------



module "networking" {
  source           = "./networking"
  omegavpc_cidr    = local.omega_vpc
  max_subnets      = 20
  public_sn_count  = 3
  private_sn_count = 3
  security_groups  = local.security_groups
  public_cidrs     = [for i in range(0, 225, 2) : cidrsubnet(local.omega_vpc, 8, i)]
  private_cidrs    = [for i in range(1, 225, 2) : cidrsubnet(local.omega_vpc, 8, i)]
  db_subnet_group  = true
}


module "loadbalancing" {
  source                            = "./loadbalancing" # db_subnet_group_name
  public_sg                         = module.networking.db_security_group_lb
  public_subnets                    = module.networking.db_subnets_lb
  tg_port                           = 8000 # 0
  tg_portocol                       = "HTTP"
  vpc_id                            = module.networking.vpc_id
  Project-Omega_healthy_threshold   = 2
  Project-Omega_unhealthy_threshold = 2
  lb_timeout                        = 3
  lb_interval                       = 30
  listener_port                     = 80
  listener_protocol                 = "HTTP"
}

module "database" {
  source                 = "./database"
  db_storage             = 300
  engine_version         = "5.7.22"
  instance_class         = "db.t3.micro"
  name                   = var.dbname
  username               = var.username
  password               = var.password
  identifier             = "queendb"
  multi_az               = true
  skip_db_snapshot       = true
  db_subnet_group_name   = module.networking.db_subnet_group_name[0]
  vpc_security_group_ids = module.networking.db_security_group
}
module "compute" {
  source              = "./compute"
  instance_count      = 2
  public_sn_count     = 3
  instance_type       = var.intanceec2
  public_sg           = module.networking.db_security_group_lb # db_security_group_lb
  public_subnets      = module.networking.db_subnets_lb
  keypair_name        = "hapletkey"
  public_key_path     = var.public_key_path
  user_data_path      = "${path.root}/userdata.tpl"
  name                = var.dbname
  username            = var.username
  password            = var.password
  vol_size            = 10
  lb_target_group_arn = module.loadbalancing.lb_target_group_arn
  db_endpoint         = module.database.db_endpoint
}

 