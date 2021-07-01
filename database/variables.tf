#### ---- database/variables.tf -------------



variable "db_storage" {}
#variable  "postgreSQL" {}
variable "engine_version" {}
variable "instance_class" {}
variable "name" {}
variable "username" {}
variable "password" {}
variable "db_subnet_group_name" {}
variable "vpc_security_group_ids" {}
variable "identifier" {}
variable "skip_db_snapshot" {}
variable "multi_az" {
   type = bool
 }
