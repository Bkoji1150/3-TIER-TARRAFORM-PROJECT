#### networking/variables.tf -----

variable "omegavpc_cidr" {
  type        = string
  description = "main vpc cidr block"
}

variable "max_subnets" {}

 variable "public_sn_count" {
  #type = list
  description = "Provide your desired count for OMEGA VPC"
 }

 variable "public_cidrs" {
  type = list 
  description = "Provide your desired Cidr for OMEGA VPC"
 }

 variable "private_sn_count" {
  #type = list
  description = "Provide your desired count for OMEGA VPC"
 }

 variable "private_cidrs" {
  type = list 
  description = "Provide your desired Cidr for OMEGA VPC"
 }
 
 variable "security_groups" {}

 variable "db_subnet_group" {}
