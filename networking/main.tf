 #### networking/main.tf -----

 data "aws_availability_zones" "available" {
  #state = "available"
 }

 resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names # for aws to randomly chose and assign az
  result_count = var.max_subnets
 }

 resource "random_integer" "random" {
  min = 1
  max = 100
  }

 resource "aws_vpc" "omega_vpc" {
  cidr_block       = var.omegavpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true 
  tags = {
    Name = "omega_vpc-${random_integer.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
 }

 resource "aws_subnet" "OmegaVPCPubSubNet" {
  #count = length(var.public_cidrs)
  count                   = var.public_sn_count # 3
  vpc_id                  = aws_vpc.omega_vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  #availability_zone = var.Pubavailabilityzone[count.index] #(hard coded)
  ##availability_zone = data.aws_availability_zones.available.names[count.index] # Not hard coded # for aws to randomly chose and assign az
  availability_zone = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "omegaVPCPubSubNet_${count.index + 1}"
  }
 }

 resource "aws_subnet" "OmegaVPCPrivSubNet" {
  #count = length(var.public_cidrs)
  count                   = var.private_sn_count # 3
  vpc_id                  = aws_vpc.omega_vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = true
  #availability_zone = var.Pubavailabilityzone[count.index] #(hard coded)
  ##availability_zone = data.aws_availability_zones.available.names[count.index] # Not hard coded # for aws to randomly chose and assign az
  availability_zone = random_shuffle.az_list.result[count.index]
  tags = {
    Name = "omegaVPCPrivSubNet_${count.index + 1}"
  }
 }

  resource "aws_internet_gateway" "project-Omega_internet_gateway" {
  vpc_id = aws_vpc.omega_vpc.id
  tags = {
    name = "project-Omega_igw"
  } 
 }
 
  resource "aws_route_table" "Project-Omega_public_rt" {
  vpc_id = aws_vpc.omega_vpc.id
  tags = {
    name = "Project-Omega_public_rt"
  }
 }

 resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.Project-Omega_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.project-Omega_internet_gateway.id 
 }

 resource "aws_default_route_table" "Omega_private_rt" {
  default_route_table_id = aws_vpc.omega_vpc.default_route_table_id
  tags = {
    name = "Project-Omega_private_rt"
  }
 }

 resource "aws_route_table_association" "Project-Omega_public_assoc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.OmegaVPCPubSubNet.*.id[count.index]
  route_table_id = aws_route_table.Project-Omega_public_rt.id
  } 

   resource "aws_security_group" "Project-Omega_sg" {
   for_each    = var.security_groups
   name        = each.value.name
   description = each.value.description
   vpc_id      = aws_vpc.omega_vpc.id

   dynamic "ingress" {
    for_each = each.value.ingress
    content {
      #description      =
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow ssh and http"
  }
}

resource "aws_db_subnet_group" "Project-Omega_rds_subnetgroup" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "project-omega_rds_subnetgroup"
  subnet_ids = aws_subnet.OmegaVPCPrivSubNet.*.id
  tags = {
    Name = "My  Project-Omega private subnet group"
  }
 }
  

  







