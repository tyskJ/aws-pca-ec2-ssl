# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform output.tf output                                                                                                   ║
# ╠═════════════════════════════╤════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
# ║ linux_privateip             │ Private IP of the linux host                                                                                       ║
# ║ windows_privateip           │ Private IP of the windows host                                                                                     ║
# ╚═════════════════════════════╧════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

output "linux_privateip" {
  description = "Private IP of the linux host."
  value       = aws_instance.linux_instance.private_ip
}

output "windows_privateip" {
  description = "Private IP of the windows host."
  value       = aws_instance.windows_instance.private_ip
}
