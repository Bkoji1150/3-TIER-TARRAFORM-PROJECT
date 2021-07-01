### ---- networkinterface/main.rf

 
 /*resource "aws_network_interface" "project-omega" {
  subnet_id     = "${element(var.subnet_id, count.index)}"
  count =   var.public_sn_count[0]
  private_ips     = var.private_ips
  security_groups = var.security_groups 
  } 
  
  resource "aws_eip" "project-omegae_eip" {
   vpc                       = true
   count =    var.public_sn_count[1]
  network_interface         = aws_network_interface.project-omega[count.index].id
  associate_with_private_ip = var.private_ips
  }*/
  



  