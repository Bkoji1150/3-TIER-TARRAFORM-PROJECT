#### networking/outputs.tf -----

output "vpc_id" {
  value       = aws_vpc.omega_vpc.id
  sensitive   = true
  description = "Project Omaga vpc id"
  #depends_on  = []
}

 output "db_subnet_group_name" {
    value = aws_db_subnet_group.Project-Omega_rds_subnetgroup.*.name 
 }
 
 output "db_security_group" {
  value = [aws_security_group.Project-Omega_sg["rds"].id] # Just are specific RDS instance
}

 output  "db_security_group_lb" {
     value = [aws_security_group.Project-Omega_sg["public"].id]
 }

  output "db_subnets_lb" {
  value = aws_subnet.OmegaVPCPubSubNet.*.id # Referesh subnet group by name
 }

 output "subnet_id-interface" {
     value = aws_subnet.OmegaVPCPubSubNet.*.id
 }  
   
  output "projectomega-igw" {
     value = aws_internet_gateway.project-Omega_internet_gateway
 }
   
    


 


