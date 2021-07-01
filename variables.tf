variable "aws_region" {
  #type        = string
  default     = "us-east-1"
  description = "Please Provide Your Desired AWS Region"
}
variable "dbname" {
  type    = string
  default = "target"
}

variable "username" {
  type      = string
  sensitive = true
}
 
 
variable "password" {
  sensitive = true
  #default = 
}

variable "intanceec2" {
  #type      = string
  sensitive = true
}

variable "goldenAMI" {
  type = list(any)
}
variable "public_key_path" {
  sensitive = true
}  
 











