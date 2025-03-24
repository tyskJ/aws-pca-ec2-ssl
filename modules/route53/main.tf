# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform main.tf resource                                                                                                   ║
# ╠════════════════════════════════════╤═════════════════════════════════════════════════════╤═══════════════════════════════════════════════════════╣
# ║ private_hostedzone                 │ aws_route53_zone                                    │ Private Hosted Zone.                                  ║
# ║ linux_recordset                    │ aws_route53_record                                  │ A Record Set for Linux host.                          ║
# ║ windows_recordset                  │ aws_route53_record                                  │ A Record Set for Windows host.                        ║
# ╚════════════════════════════════════╧═════════════════════════════════════════════════════╧═══════════════════════════════════════════════════════╝

resource "aws_route53_zone" "private_hostedzone" {
  name          = "pcassl.com"
  force_destroy = true
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "linux_recordset" {
  zone_id = aws_route53_zone.private_hostedzone.zone_id
  name    = "linux.pcassl.com"
  type    = "A"
  ttl     = 300
  records = [var.linux_privateip]
}

resource "aws_route53_record" "windows_recordset" {
  zone_id = aws_route53_zone.private_hostedzone.zone_id
  name    = "windows.pcassl.com"
  type    = "A"
  ttl     = 300
  records = [var.windows_privateip]
}
