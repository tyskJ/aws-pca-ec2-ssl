# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform output.tf output                                                                                                   ║
# ╠═════════════════════════════╤════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
# ║ vpc_id                      │ VPC ID.                                                                                                            ║
# ║ subnetid_for_bastion        │ Subnet ID for Bastion EC2.                                                                                         ║
# ║ subnetid_for_linux          │ Subnet ID for Linux EC2.                                                                                           ║
# ║ subnetid_for_windows        │ Subnet ID for Windows EC2.                                                                                         ║
# ║ sgid_for_bastion            │ SecurityGroup ID for Bastion EC2.                                                                                  ║
# ║ sgid_for_linux              │ SecurityGroup ID for Linux EC2.                                                                                    ║
# ║ sgid_for_windows            │ SecurityGroup ID for Windows EC2.                                                                                  ║
# ╚═════════════════════════════╧════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.vpc.id
}

output "subnetid_for_bastion" {
  description = "Subnet ID for Bastion EC2."
  value       = aws_subnet.subnet["public-subnet-a"].id
}

output "subnetid_for_linux" {
  description = "Subnet ID for Linux EC2."
  value       = aws_subnet.subnet["private-subnet-a"].id
}

output "subnetid_for_windows" {
  description = "Subnet ID for Windows EC2."
  value       = aws_subnet.subnet["private-subnet-c"].id
}

output "sgid_for_bastion" {
  description = "SecurityGroup ID for Bastion EC2."
  value       = aws_security_group.bastion_ec2_sg.id
}

output "sgid_for_linux" {
  description = "SecurityGroup ID for Linux EC2."
  value       = aws_security_group.linux_ec2_sg.id
}

output "sgid_for_windows" {
  description = "SecurityGroup ID for Windows EC2."
  value       = aws_security_group.windows_ec2_sg.id
}
