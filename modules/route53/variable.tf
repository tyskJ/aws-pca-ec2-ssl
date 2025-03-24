# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform variable.tf variable                                                                                               ║
# ╠══════════════════════════════════╤═══════════════════════════════════╤═══════════════════════════════════════════════════════════════════════════╣
# ║ vpc_id                           │ string                            │ VPC ID for association Private HostedZone.                                ║
# ║ linux_privateip                  │ string                            │ Private IP of the linux host.                                             ║
# ║ windows_privateip                │ string                            │ Private IP of the Windows host.                                           ║
# ╚══════════════════════════════════╧═══════════════════════════════════╧═══════════════════════════════════════════════════════════════════════════╝

variable "vpc_id" {
  type        = string
  description = "VPC ID for association Private HostedZone."
}

variable "linux_privateip" {
  type        = string
  description = "Private IP of the linux host."
}

variable "windows_privateip" {
  type        = string
  description = "Private IP of the windows host."
}
