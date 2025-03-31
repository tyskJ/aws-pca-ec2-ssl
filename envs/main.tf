# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform main.tf module                                                                                                     ║
# ╠═════════════════╤═══════════════════════════════════╤════════════════════════════════════════════════════════════════════════════════════════════╣
# ║ nw              │ ../modules/nw                     │ invoke Network module.                                                                     ║
# ║ iam             │ ../modules/iam                    │ invoke IAM module.                                                                         ║
# ║ key             │ ../modules/key                    │ invoke Key module.                                                                         ║
# ║ ec2             │ ../modules/ec2                    │ invoke EC2 module.                                                                         ║
# ║ route53         │ ../modules/route53                │ invoke Route53 module.                                                                     ║
# ║ pca             │ ../modules/pca                    │ invoke PCA module.                                                                         ║
# ╚═════════════════╧═══════════════════════════════════╧════════════════════════════════════════════════════════════════════════════════════════════╝

module "nw" {
  source  = "../modules/nw"
  vpc_map = { "name" = "vpc", "cidr" = "10.0.0.0/16", "dnshost" = true, "dnssupport" = true }
  subnet_map_list = (
    [
      { "name" = "public-subnet-a", "cidr" = "10.0.1.0/24", "az_name" = "${local.region_name}a", "publicip" = true },
      { "name" = "public-subnet-c", "cidr" = "10.0.2.0/24", "az_name" = "${local.region_name}c", "publicip" = true },
      { "name" = "private-subnet-a", "cidr" = "10.0.3.0/24", "az_name" = "${local.region_name}a", "publicip" = false },
      { "name" = "private-subnet-c", "cidr" = "10.0.4.0/24", "az_name" = "${local.region_name}c", "publicip" = false }
    ]
  )
  nacl_assoc_list = ["public-subnet-a", "public-subnet-c", "private-subnet-a", "private-subnet-c"]
}

module "iam" {
  source    = "../modules/iam"
  partition = local.partition_name
}

module "key" {
  source = "../modules/key"
}

module "ec2" {
  source               = "../modules/ec2"
  keypair_name         = module.key.keypair_name
  instanceprofile_name = module.iam.instanceprofile_name
  bastion_ec2_map = (
    {
      "name" = "bastion-ec2", "instancetype" = "t3.large", "volname" = "ebs-root", "volumesize" = "30",
      "sgid" = module.nw.sgid_for_bastion, "subnetid" = module.nw.subnetid_for_bastion
    }
  )
  linux_ec2_map = (
    {
      "name" = "linux-ec2", "instancetype" = "t3.large", "volname" = "ebs-root", "volumesize" = "30",
      "sgid" = module.nw.sgid_for_linux, "subnetid" = module.nw.subnetid_for_linux
    }
  )
  windows_ec2_map = (
    {
      "name" = "windows-ec2", "instancetype" = "t3.large", "volname" = "ebs-root", "volumesize" = "30",
      "sgid" = module.nw.sgid_for_windows, "subnetid" = module.nw.subnetid_for_windows
    }
  )
}

module "route53" {
  source            = "../modules/route53"
  vpc_id            = module.nw.vpc_id
  linux_privateip   = module.ec2.linux_privateip
  windows_privateip = module.ec2.windows_privateip
}

# module "pca" {
#   source            = "../modules/pca"
#   account_id        = local.account_id
#   issuename_linux   = module.route53.linux_fqdn
#   issuename_windows = module.route53.windows_fqdn
# }
