# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform variable.tf variable                                                                                               ║
# ╠══════════════════════════════════╤═══════════════════════════════════╤═══════════════════════════════════════════════════════════════════════════╣
# ║ keypair_name                     │ string                            │ Key pair name.                                                            ║
# ║ instanceprofile_name             │ string                            │ Instance profile name.                                                    ║
# ║ bastion_ec2_map                  │ map(string)                       │ Bastion EC2 settings map.                                                 ║
# ║ linux_ec2_map                    │ map(string)                       │ Linux EC2 settings map.                                                   ║
# ║ windows_ec2_map                  │ map(string)                       │ Windows EC2 settings map.                                                 ║
# ╚══════════════════════════════════╧═══════════════════════════════════╧═══════════════════════════════════════════════════════════════════════════╝

variable "keypair_name" {
  type        = string
  description = "Key pair name."
}

variable "instanceprofile_name" {
  type        = string
  description = "Instance profile name."
}

variable "bastion_ec2_map" {
  type        = map(string)
  description = "Bastion EC2 settings map."
}

variable "linux_ec2_map" {
  type        = map(string)
  description = "Linux EC2 settings map."
}

variable "windows_ec2_map" {
  type        = map(string)
  description = "Windows EC2 settings map."
}
