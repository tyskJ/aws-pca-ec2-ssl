# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform output.tf output                                                                                                   ║
# ╠═════════════════════════════╤════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╣
# ║ linux_fqdn                  │ FQDN for Linux host.                                                                                               ║
# ║ windows_fqdn                │ FQDN for Windows host.                                                                                             ║
# ╚═════════════════════════════╧════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝

output "linux_fqdn" {
  description = "FQDN for Linux host."
  value       = aws_route53_record.linux_recordset.fqdn
}

output "windows_fqdn" {
  description = "FQDN for Windows host."
  value       = aws_route53_record.windows_recordset.fqdn
}
