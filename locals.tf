locals {
  project_prefix    = random_string.prefix.result
  deploy_date       = formatdate("YYYY-MM-DD", timestamp())
  resource_group_id = var.existing_resource_group != "" ? data.ibm_resource_group.group.0.id : ibm_resource_group.group.0.id
  ssh_key_ids       = var.existing_ssh_key != "" ? [data.ibm_is_ssh_key.sshkey[0].id, ibm_is_ssh_key.generated_key.id] : [ibm_is_ssh_key.generated_key.id]

  zones = length(data.ibm_is_zones.regional.zones)
  vpc_zones = {
    for zone in range(local.zones) : zone => {
      zone = "${var.region}-${zone + 1}"
    }
  }

  tags = [
    "vpc:${local.project_prefix}-vpc",
    "region:${var.region}",
    "owner:${var.owner}",
    "workspace:${terraform.workspace}",
    "provider:ibmcloud",
    "deployed:${local.deploy_date}"
  ]
}