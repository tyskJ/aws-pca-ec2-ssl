# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform main.tf module                                                                                                     ║
# ╠═════════════════╤═══════════════════════════════════╤════════════════════════════════════════════════════════════════════════════════════════════╣
# ║ nw              │ ../modules/nw                     │ invoke Network module.                                                                     ║
# ║ iam             │ ../modules/iam                    │ invoke IAM module.                                                                         ║
# ║ key             │ ../modules/key                    │ invoke Key module.                                                                         ║
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
