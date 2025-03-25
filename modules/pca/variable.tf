# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform variable.tf variable                                                                                               ║
# ╠══════════════════════════════════╤═══════════════════════════════════╤═══════════════════════════════════════════════════════════════════════════╣
# ║ account_id                       │ string                            │ AWS Account ID.                                                           ║
# ║ issuename_linux                  │ string                            │ Issue Certificate Domain Name for Linux host.                             ║
# ║ issuename_windows                │ string                            │ Issue Certificate Domain Name for Windows host.                           ║
# ╚══════════════════════════════════╧═══════════════════════════════════╧═══════════════════════════════════════════════════════════════════════════╝

variable "account_id" {
  type        = string
  description = "AWS Account ID."
}

variable "issuename_linux" {
  type        = string
  description = "Issue Certificate Domain Name for Linux host."
}

variable "issuename_windows" {
  type        = string
  description = "Issue Certificate Domain Name for Windows host."
}
