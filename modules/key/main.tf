# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform main.tf resource                                                                                                   ║
# ╠════════════════════════════════════╤═════════════════════════════════════════════════════╤═══════════════════════════════════════════════════════╣
# ║ ssh_keygen                         │ tls_private_key                                     │ setting SSH keygen algorithm.                         ║
# ║ keypair_pem                        │ local_sensitive_file                                │ create private key file to local.                     ║
# ║ keypair                            │ aws_key_pair                                        │ Key Pair.                                             ║
# ╚════════════════════════════════════╧═════════════════════════════════════════════════════╧═══════════════════════════════════════════════════════╝

resource "tls_private_key" "ssh_keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "keypair_pem" {
  filename        = "./.keypair/keypair.pem"
  content         = tls_private_key.ssh_keygen.private_key_pem
  file_permission = "0600"
}

resource "aws_key_pair" "keypair" {
  key_name   = "keypair"
  public_key = tls_private_key.ssh_keygen.public_key_openssh
  tags = {
    Name = "keypair"
  }
}
