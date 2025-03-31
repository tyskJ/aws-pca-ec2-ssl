# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform main.tf resource                                                                                                   ║
# ╠════════════════════════════════════╤═════════════════════════════════════════════════════╤═══════════════════════════════════════════════════════╣
# ║ bastion_instance                   │ aws_instance                                        │ Bastion EC2 Instance.                                 ║
# ║ linux_instance                     │ aws_instance                                        │ Linux EC2 Instance.                                   ║
# ║ windows_instance                   │ aws_instance                                        │ Windows EC2 Instance.                                 ║
# ╚════════════════════════════════════╧═════════════════════════════════════════════════════╧═══════════════════════════════════════════════════════╝

resource "aws_instance" "bastion_instance" {
  ami                         = data.aws_ssm_parameter.windowsserver_2022.value
  associate_public_ip_address = true
  iam_instance_profile        = var.instanceprofile_name
  key_name                    = var.keypair_name
  instance_type               = var.bastion_ec2_map.instancetype
  root_block_device {
    volume_size           = var.bastion_ec2_map.volumesize
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name = var.bastion_ec2_map.volname
    }
  }
  metadata_options {
    http_tokens = "required"
  }
  subnet_id              = var.bastion_ec2_map.subnetid
  vpc_security_group_ids = [var.bastion_ec2_map.sgid]
  tags = {
    Name = var.bastion_ec2_map.name
  }
}

resource "aws_instance" "linux_instance" {
  ami                         = data.aws_ssm_parameter.amazonlinux_2023.value
  associate_public_ip_address = true
  iam_instance_profile        = var.instanceprofile_name
  key_name                    = var.keypair_name
  instance_type               = var.linux_ec2_map.instancetype
  root_block_device {
    volume_size           = var.linux_ec2_map.volumesize
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name = var.linux_ec2_map.volname
    }
  }
  metadata_options {
    http_tokens = "required"
  }
  subnet_id              = var.linux_ec2_map.subnetid
  vpc_security_group_ids = [var.linux_ec2_map.sgid]
  tags = {
    Name = var.linux_ec2_map.name
  }
}

resource "aws_instance" "windows_instance" {
  ami                         = data.aws_ssm_parameter.windowsserver_2022.id
  associate_public_ip_address = true
  iam_instance_profile        = var.instanceprofile_name
  key_name                    = var.keypair_name
  instance_type               = var.windows_ec2_map.instancetype
  root_block_device {
    volume_size           = var.windows_ec2_map.volumesize
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    encrypted             = true
    tags = {
      Name = var.windows_ec2_map.volname
    }
  }
  metadata_options {
    http_tokens = "required"
  }
  subnet_id              = var.windows_ec2_map.subnetid
  vpc_security_group_ids = [var.windows_ec2_map.sgid]
  tags = {
    Name = var.windows_ec2_map.name
  }
}
