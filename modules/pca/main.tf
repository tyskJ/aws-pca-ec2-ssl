# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform main.tf resource                                                                                                   ║
# ╠════════════════════════════════════╤═════════════════════════════════════════════════════╤═══════════════════════════════════════════════════════╣
# ║ root_ca                            │ aws_acmpca_certificate_authority                    │ Root CA.                                              ║
# ║ certificate_for_ca                 │ aws_acmpca_certificate                              │ Certificate For CAs.                                  ║
# ║ assoc_cert_to_ca                   │ aws_acmpca_certificate_authority_certificate        │ Association Certificate to CAs.                       ║
# ║ add_permission_to_acm              │ aws_acmpca_permission                               │ Add permission to ACM.                                ║
# ╚════════════════════════════════════╧═════════════════════════════════════════════════════╧═══════════════════════════════════════════════════════╝

// Root CA
resource "aws_acmpca_certificate_authority" "root_ca" {
  type                            = "ROOT"
  usage_mode                      = "SHORT_LIVED_CERTIFICATE"
  permanent_deletion_time_in_days = 7
  key_storage_security_standard   = "FIPS_140_2_LEVEL_3_OR_HIGHER"
  tags = {
    Name = "root-ca"
  }
  certificate_authority_configuration {
    key_algorithm     = "RSA_2048"
    signing_algorithm = "SHA256WITHRSA"
    subject {
      organization = "example"
      country      = "JP"
    }
  }
}

// Issue certificates for private CAs
resource "aws_acmpca_certificate" "certificate_for_ca" {
  certificate_authority_arn   = aws_acmpca_certificate_authority.root_ca.arn
  certificate_signing_request = aws_acmpca_certificate_authority.root_ca.certificate_signing_request
  signing_algorithm           = "SHA256WITHRSA"
  validity {
    type  = "YEARS"
    value = 1
  }
  template_arn = "arn:aws:acm-pca:::template/RootCACertificate/V1"
}

// Associate(install) certificates to private CAs to allow issuance of certificates from private CAs
resource "aws_acmpca_certificate_authority_certificate" "assoc_cert_to_ca" {
  certificate_authority_arn = aws_acmpca_certificate_authority.root_ca.arn
  certificate               = aws_acmpca_certificate.certificate_for_ca.certificate
}

// Authority to operate PCA from ACM for this account
resource "aws_acmpca_permission" "add_permission_to_acm" {
  certificate_authority_arn = aws_acmpca_certificate_authority.root_ca.arn
  principal                 = "acm.amazonaws.com"
  actions                   = ["IssueCertificate", "GetCertificate", "ListPermissions"]
  source_account            = var.account_id
}
