### root/outputs.tf -----

output "load_balancer_endpoint" {
  description = "This is you lb enpoint smile"
  value       = module.loadbalancing.lb_endpoint
}



/*output "instance" {
     value = {for i in module.compute.instance : i.tags.Name => i.public_ip}
     sensitive = false # for sensitive value check true
 }*/

