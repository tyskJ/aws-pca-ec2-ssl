# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL redirect Stack - Terraform data.tf data                                                                                              ║
# ╠═══════════════════════╤═══════════════════════════════════╤══════════════════════════════════════════════════════════════════════════════════════╣
# ║ amazonlinux_2023      │ aws_ssm_parameter                 │ Amazon Linux 2023 latest ami id.                                                     ║
# ║ windowsserver_2022    │ aws_ssm_parameter                 │ Windows Server 2022 latest ami id.                                                   ║
# ╚═══════════════════════╧═══════════════════════════════════╧══════════════════════════════════════════════════════════════════════════════════════╝

data "aws_ssm_parameter" "amazonlinux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-x86_64"
}

data "aws_ssm_parameter" "windowsserver_2022" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2022-Japanese-Full-Base"
}
