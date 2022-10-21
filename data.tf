data "ibm_resource_group" "group" {
  count = var.existing_resource_group != "" ? 1 : 0
  name  = var.existing_resource_group
}

data "ibm_is_ssh_key" "sshkey" {
  count = var.existing_ssh_key != "" ? 1 : 0
  name  = var.existing_ssh_key
}
