resource "random_string" "prefix" {
  count   = var.prefix != "" ? 0 : 1
  length  = 8
  special = false
}

# If an existing resource group is not specified, terraform will create a new one and use it for all deployed resources.
resource "ibm_resource_group" "group" {
  count = var.existing_resource_group != "" ? 0 : 1
  name  = "${var.prefix}-resource-group"
  tags  = local.tags
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# If an existing SSH key is not specified, terraform will create a new one and use it for all deployed resources. 
resource "ibm_is_ssh_key" "generated_key" {
  name           = "${var.prefix}-${var.region}-key"
  public_key     = tls_private_key.ssh.public_key_openssh
  resource_group = local.resource_group_id
  tags           = local.tags
}

module "vpc" {
  source = "terraform-ibm-modules/vpc/ibm//modules/vpc"

  create_vpc                  = true
  vpc_name                    = "${local.project_prefix}-vpc"
  resource_group_id           = data.ibm_resource_group.group.id
  classic_access              = false
  default_address_prefix      = "auto"
  default_network_acl_name    = "${local.project_prefix}-vpc-default-network-acl"
  default_security_group_name = "${local.project_prefix}-vpc-default-security-group"
  default_routing_table_name  = "${local.project_prefix}-vpc-default-routing-table"
  vpc_tags                    = local.tags
  locations                   = [local.vpc_zones.0.zone, local.vpc_zones.1.zone]
  subnet_name                 = "${local.project_prefix}-vpc-subnet"
  number_of_addresses         = "128"
  create_gateway              = true
  public_gateway_name         = "${local.project_prefix}-vpc-pub-gw"
  gateway_tags                = local.tags
}


resource "consul_key_prefix" "vpc_info" {
  path_prefix = "ibmcloud/deployed_resources/${terraform.workspace}/vpc/${local.project_prefix}/"

  subkeys = {
    "vpc_name"                = "${local.project_prefix}-vpc"
    "vpc_id"                  = "${module.vpc.vpc_id[0]}"
    "vpc_default_network_acl" = "${module.vpc.vpc_default_network_acl[0]}"
  }
}

