# ╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
# ║ PCA EC2 SSL Stack - Terraform main.tf resource                                                                                                   ║
# ╠════════════════════════════════════╤═════════════════════════════════════════════════════╤═══════════════════════════════════════════════════════╣
# ║ vpc                                │ aws_vpc                                             │ VPC.                                                  ║
# ║ subnet                             │ aws_subnet                                          │ Subnet.                                               ║
# ║ nacl                               │ aws_network_acl                                     │ NACL.                                                 ║
# ║ nacl_in_rule100                    │ aws_network_acl_rule                                │ NACL Inbound Rule.                                    ║
# ║ nacl_out_rule100                   │ aws_network_acl_rule                                │ NACL Outbound Rule.                                   ║
# ║ assoc_nacl                         │ aws_network_acl_association                         │ NACL Association Subnet.                              ║
# ║ igw                                │ aws_internet_gateway                                │ IGW.                                                  ║
# ║ eip                                │ aws_eip                                             │ Elastic IP for NAT Gateway.                           ║
# ║ ngw                                │ aws_nat_gateway                                     │ NAT Gateway.                                          ║
# ║ rtb_public                         │ aws_route_table                                     │ Public RouteTable.                                    ║
# ║ rtb_private                        │ aws_route_table                                     │ Private RouteTable.                                   ║
# ║ assoc_rtb_pub1                     │ aws_route_table_association                         │ RouteTable Association Subnet.                        ║
# ║ assoc_rtb_pub2                     │ aws_route_table_association                         │ RouteTable Association Subnet.                        ║
# ║ assoc_rtb_pri1                     │ aws_route_table_association                         │ RouteTable Association Subnet.                        ║
# ║ assoc_rtb_pri2                     │ aws_route_table_association                         │ RouteTable Association Subnet.                        ║
# ╚════════════════════════════════════╧═════════════════════════════════════════════════════╧═══════════════════════════════════════════════════════╝

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_map.cidr
  enable_dns_hostnames = var.vpc_map.dnshost
  enable_dns_support   = var.vpc_map.dnssupport
  tags = {
    Name = var.vpc_map.name
  }
}

resource "aws_subnet" "subnet" {
  for_each                = { for i in var.subnet_map_list : i.name => i }
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.az_name
  cidr_block              = each.value.cidr
  map_public_ip_on_launch = each.value.publicip
  tags = {
    Name = each.value.name
  }
}

resource "aws_network_acl" "nacl" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "nacl"
  }
}

resource "aws_network_acl_rule" "nacl_in_rule100" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = false
  protocol       = -1
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "nacl_out_rule100" {
  network_acl_id = aws_network_acl.nacl.id
  rule_number    = 100
  rule_action    = "allow"
  egress         = true
  protocol       = -1
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_association" "assoc_nacl" {
  for_each       = toset(var.nacl_assoc_list)
  network_acl_id = aws_network_acl.nacl.id
  subnet_id      = aws_subnet.subnet[each.value].id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "eip" {
  tags = {
    Name = "eip-ngw"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id     = aws_eip.eip.allocation_id
  connectivity_type = "public"
  subnet_id         = aws_subnet.subnet["public-subnet-c"].id
  tags = {
    Name = "ngw"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rtb-public"
  }
}

resource "aws_route_table" "rtb_private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "rtb-private"
  }
}

resource "aws_route_table_association" "assoc_rtb_pub1" {
  subnet_id      = aws_subnet.subnet["public-subnet-a"].id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "assoc_rtb_pub2" {
  subnet_id      = aws_subnet.subnet["public-subnet-c"].id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "assoc_rtb_pri1" {
  subnet_id      = aws_subnet.subnet["private-subnet-a"].id
  route_table_id = aws_route_table.rtb_private.id
}

resource "aws_route_table_association" "assoc_rtb_pri2" {
  subnet_id      = aws_subnet.subnet["private-subnet-c"].id
  route_table_id = aws_route_table.rtb_private.id
}
