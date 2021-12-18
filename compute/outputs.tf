## --- compute/outputs -----


/*output "instance" {
     value = aws_instance.project-omega[*]
     sensitive = false # for sensitive value check true
 }
 */

output "instance" {
  value     = { for i in aws_instance.project-omega : i.tags.Name => i.private_ip }
  sensitive = false # for sensitive value check true
}
